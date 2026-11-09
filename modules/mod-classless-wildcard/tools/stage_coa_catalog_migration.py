#!/usr/bin/env python3
"""Turn generated CoA catalog SQL into a scoped, review-only world migration."""

import argparse
import json
import os
import re


def split_statements(sql):
    """Split SQL at semicolons outside quoted strings and comments."""
    statements, start = [], 0
    quote = None
    line_comment = False
    block_comment = False
    i = 0
    while i < len(sql):
        char = sql[i]
        nxt = sql[i + 1] if i + 1 < len(sql) else ""
        if line_comment:
            if char == "\n":
                line_comment = False
        elif block_comment:
            if char == "*" and nxt == "/":
                block_comment = False
                i += 1
        elif quote:
            if char == "\\":
                i += 1
            elif char == quote:
                if nxt == quote:
                    i += 1
                else:
                    quote = None
        elif char in ("'", '"', "`"):
            quote = char
        elif char == "-" and nxt == "-" and (i + 2 == len(sql) or sql[i + 2].isspace()):
            line_comment = True
            i += 1
        elif char == "/" and nxt == "*":
            block_comment = True
            i += 1
        elif char == ";":
            statement = sql[start:i + 1].strip()
            if statement:
                statements.append(statement)
            start = i + 1
        i += 1
    trailing = sql[start:].strip()
    if trailing:
        raise ValueError("generated SQL has an unterminated statement")
    if quote or block_comment:
        raise ValueError("generated SQL ends inside a quoted string or block comment")
    return statements


def first_keyword(statement):
    without_comments = re.sub(r"(?m)^\s*--[^\n]*\n?", "", statement).lstrip()
    match = re.match(r"([A-Za-z]+)", without_comments)
    return match.group(1).upper() if match else ""


def tuple_values(statement):
    values = statement.split("VALUES", 1)[1]
    rows = []
    i = 0
    while i < len(values):
        if values[i] != "(":
            i += 1
            continue
        start, quote, depth = i + 1, None, 1
        i += 1
        while i < len(values) and depth:
            char = values[i]
            nxt = values[i + 1] if i + 1 < len(values) else ""
            if quote:
                if char == "\\":
                    i += 1
                elif char == quote:
                    if nxt == quote:
                        i += 1
                    else:
                        quote = None
            elif char in ("'", '"', "`"):
                quote = char
            elif char == "(":
                depth += 1
            elif char == ")":
                depth -= 1
                if not depth:
                    body = values[start:i]
                    fields, field_start, field_quote, nested = [], 0, None, 0
                    j = 0
                    while j < len(body):
                        current = body[j]
                        following = body[j + 1] if j + 1 < len(body) else ""
                        if field_quote:
                            if current == "\\":
                                j += 1
                            elif current == field_quote:
                                if following == field_quote:
                                    j += 1
                                else:
                                    field_quote = None
                        elif current in ("'", '"', "`"):
                            field_quote = current
                        elif current == "(":
                            nested += 1
                        elif current == ")":
                            nested -= 1
                        elif current == "," and nested == 0:
                            fields.append(body[field_start:j].strip())
                            field_start = j + 1
                        j += 1
                    fields.append(body[field_start:].strip())
                    if fields and re.fullmatch(r"\d+", fields[0]):
                        rows.append(fields)
            i += 1
    return rows


def id_chunks(ids, size=800):
    ids = sorted(set(ids))
    return [ids[i:i + size] for i in range(0, len(ids), size)]


def stage(source_path, output_path, audit_path, manifest_path):
    raw = split_statements(open(source_path, encoding="utf-8").read())
    dml = [s for s in raw if first_keyword(s) in ("DELETE", "INSERT", "UPDATE")]
    if any(first_keyword(s) in ("CREATE", "DROP", "ALTER") for s in dml):
        raise ValueError("schema statement escaped DML filtering")

    inserts = {}
    for statement in dml:
        if first_keyword(statement) != "INSERT":
            continue
        match = re.match(r"INSERT\s+INTO\s+`?([A-Za-z0-9_]+)`?", statement, re.I)
        if match:
            inserts.setdefault(match.group(1).lower(), []).append(statement)

    def inserted_ids(table):
        rows = [row for statement in inserts.get(table.lower(), []) for row in tuple_values(statement)]
        return sorted({int(row[0]) for row in rows})

    def inserted_rows(table):
        return [row for statement in inserts.get(table.lower(), []) for row in tuple_values(statement)]

    def deleted_ids(table, field="ID"):
        result = set()
        pattern = r"`?%s`?\s+IN\s*\(([^)]*)\)" % re.escape(field)
        for statement in scoped:
            match = re.match(r"DELETE\s+FROM\s+`?%s`?(?=\s|$)" % re.escape(table), statement, re.I)
            if not match:
                continue
            scope = re.search(pattern, statement, re.I)
            if scope:
                result.update(int(value) for value in re.findall(r"\d+", scope.group(1)))
        return result

    scoped = []
    for statement in dml:
        match = re.match(r"DELETE\s+FROM\s+`?([A-Za-z0-9_]+)`?", statement, re.I)
        if not match:
            scoped.append(statement)
            continue
        table = match.group(1).lower()
        if table in ("talenttab_dbc", "talent_dbc"):
            ids = inserted_ids(table)
            if not ids:
                raise ValueError("no inserted IDs found for %s cleanup" % table)
            scoped.extend("DELETE FROM `%s` WHERE `ID` IN (%s);" % (table, ", ".join(map(str, chunk)))
                          for chunk in id_chunks(ids))
        else:
            scoped.append(statement)

    header = ("-- REVIEW ONLY: paired CoA catalog DML generated from the pinned importer.\n"
              "-- Apply only after the CoA catalog schema and Hero racial access schema are reviewed/applied.\n"
              "-- Not installed, applied to a database, or accepted for release.\n\n")
    text = header + "\n\n".join(scoped) + "\n"
    os.makedirs(os.path.dirname(os.path.abspath(output_path)), exist_ok=True)
    with open(output_path, "w", encoding="utf-8", newline="\n") as out:
        out.write(text)

    # Record the exact scope of the sensitive paired DBC/catalog statements.
    statement_counts = {}
    for statement in scoped:
        keyword = first_keyword(statement)
        table_match = re.match(r"(?:DELETE\s+FROM|INSERT\s+INTO)\s+`?([A-Za-z0-9_]+)`?", statement, re.I)
        table = table_match.group(1).lower() if table_match else "other"
        statement_counts[(keyword, table)] = statement_counts.get((keyword, table), 0) + 1

    def inserted_spell_ids(table):
        result = set()
        for statement in inserts.get(table, []):
            for row in tuple_values(statement):
                if table == "skilllineability_dbc" and len(row) > 2:
                    result.add(int(row[2]))
                else:
                    result.add(int(row[0]))
        return sorted(result)

    spell_ids = inserted_spell_ids("spell_dbc")
    sla_rows = inserted_rows("skilllineability_dbc")
    sla_spell_ids = sorted({int(row[2]) for row in sla_rows if len(row) > 2})
    racial_rows = inserted_rows("cw_classless_racial_abilities")
    racial_spell_ids = sorted({int(row[0]) for row in racial_rows if row})
    manifest = json.load(open(manifest_path, encoding="utf-8"))
    manifest_spell_ids = sorted(set(int(value) for value in manifest["spells"]))
    hero_sla_valid = all(len(row) == 14 and int(row[1]) == 990 and int(row[3]) > 0
                         and int(row[4]) == 512 and int(row[9]) == 0 for row in sla_rows)
    scope_checks = {
        "spell_dbc_delete_matches_insert": deleted_ids("spell_dbc") == set(spell_ids),
        "spell_ranks_delete_matches_insert_roots": deleted_ids("spell_ranks", "first_spell_id")
        == {int(row[0]) for row in inserted_rows("spell_ranks")},
        "skilllineability_delete_matches_insert_spells": deleted_ids("skilllineability_dbc", "Spell")
        == set(sla_spell_ids),
        "racial_metadata_delete_matches_insert": deleted_ids("cw_classless_racial_abilities", "spell_id")
        == set(racial_spell_ids),
        "talenttab_delete_matches_insert": deleted_ids("talenttab_dbc") == set(inserted_ids("talenttab_dbc")),
        "talent_delete_matches_insert": deleted_ids("talent_dbc") == set(inserted_ids("talent_dbc")),
    }
    uniqueness_checks = {
        "spell_dbc_ids_unique": len(inserted_rows("spell_dbc")) == len(inserted_ids("spell_dbc")),
        "spell_rank_rows_unique": len(inserted_rows("spell_ranks"))
        == len({tuple(row) for row in inserted_rows("spell_ranks")}),
        "talent_ids_unique": len(inserted_rows("talent_dbc")) == len(inserted_ids("talent_dbc")),
        "talenttab_ids_unique": len(inserted_rows("talenttab_dbc")) == len(inserted_ids("talenttab_dbc")),
        "skilllineability_row_ids_unique": len(sla_rows) == len({int(row[0]) for row in sla_rows}),
        "skilllineability_spell_ids_unique": len(sla_spell_ids) == len(sla_rows),
    }
    audit = {
        "state": "review-only staged DML; not applied",
        "source": os.path.abspath(source_path),
        "output": os.path.abspath(output_path),
        "raw_statement_count": len(raw),
        "staged_statement_count": len(scoped),
        "schema_ddl_count_in_staged_output": 0,
        "spell_dbc_rows": len(spell_ids),
        "spell_dbc_inserted_rows_unique": uniqueness_checks["spell_dbc_ids_unique"],
        "client_manifest_spell_ids": len(manifest_spell_ids),
        "client_server_spell_sets_exactly_match": set(manifest_spell_ids) == set(spell_ids),
        "skilllineability_rows": len(sla_rows),
        "skilllineability_spell_ids_match_spell_rows": set(sla_spell_ids) == set(racial_spell_ids),
        "skilllineability_rows_hero_class_only": hero_sla_valid,
        "racial_metadata_rows": len(racial_rows),
        "racial_metadata_pairs_unique": len({(int(row[0]), int(row[1])) for row in racial_rows}) == len(racial_rows),
        "racial_metadata_and_skillline_spell_sets_match": set(racial_spell_ids) == set(sla_spell_ids),
        "talenttab_cleanup_ids": len(inserted_ids("talenttab_dbc")),
        "talent_cleanup_ids": len(inserted_ids("talent_dbc")),
        "scoped_cleanup_checks": scope_checks,
        "uniqueness_checks": uniqueness_checks,
        "statement_counts": {"%s:%s" % key: value for key, value in sorted(statement_counts.items())},
    }
    if not audit["client_server_spell_sets_exactly_match"]:
        raise ValueError("client manifest and server Spell.dbc insertion sets differ")
    if not audit["skilllineability_spell_ids_match_spell_rows"] or not hero_sla_valid:
        raise ValueError("racial SkillLineAbility rows are not complete and Hero-only")
    if not audit["racial_metadata_pairs_unique"]:
        raise ValueError("racial metadata contains duplicate race/spell pairs")
    if not all(scope_checks.values()):
        raise ValueError("one or more cleanup scopes do not exactly match generated rows")
    if not all(uniqueness_checks.values()):
        raise ValueError("one or more generated DBC/catalog tables contain duplicate IDs or rows")
    with open(audit_path, "w", encoding="utf-8", newline="\n") as out:
        json.dump(audit, out, indent=2)
        out.write("\n")
    print(json.dumps(audit, indent=2))


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--source", required=True, help="generated cw_spells_coa.sql")
    parser.add_argument("--output", required=True, help="review-only pending world migration path")
    parser.add_argument("--audit", required=True, help="JSON scope receipt path")
    parser.add_argument("--manifest", required=True, help="paired client catalog manifest")
    args = parser.parse_args()
    stage(args.source, args.output, args.audit, args.manifest)


if __name__ == "__main__":
    main()
