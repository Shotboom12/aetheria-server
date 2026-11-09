"""Builds the client half of the elemental ability variants and the Forged spells (names, icons, tooltips).

The worldserver registers these spells from spell_dbc, but the client only knows spells that are in its own Spell.dbc, so
without this archive they show as "Spell 950176" with a question-mark icon. This reads the player's own client tables
(including the CoA patch already installed), appends the manifest's rows with lib/elemental.py and lib/forged.py
(Kalibros' EsteriaWoW client-patch code), and writes one small archive that must sort AFTER the CoA archive:

  python build_variants_patch.py --data "E:\\...\\clean-client\\Data" --out <archive path> [--icons]

Without --icons the variants reuse their base ability's icon (Pillow is not required). With --icons they get painted
element icons; that needs Pillow (python -m pip install --user pillow).

The manifests carry a generation id that the worldserver logs when it loads cw_ability_variants; the two must match.
"""
import argparse
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

from lib import clientfs, elemental, forged, mpq  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--data", required=True, help="the client's Data folder")
    ap.add_argument("--locale", default="enUS")
    ap.add_argument("--out", required=True)
    ap.add_argument("--icons", action="store_true", help="paint element icons (needs Pillow)")
    ap.add_argument("--exclude", action="append", default=[],
                    help="archive names to ignore when reading (own earlier output)")
    args = ap.parse_args()

    report = []
    payload = {}
    own = {os.path.basename(args.out).lower()} | {n.lower() for n in args.exclude}
    with clientfs.ClientFiles(args.data, args.locale, exclude=own) as files:
        # This client (wowdecomp) loads every archive in one alphabetical, case-insensitive order, locale folder or
        # not, and the last one wins -- not "locale patches above base ones" as clientfs assumes for a stock client.
        # Reading by that order is what makes the CoA archive's Spell.dbc the base we append to.
        found = []
        for folder in (args.data, os.path.join(args.data, args.locale)):
            if os.path.isdir(folder):
                found += [os.path.join(folder, n) for n in os.listdir(folder) if n.lower().endswith(".mpq")]
        found = [p for p in found if os.path.basename(p).lower() not in own]
        found.sort(key=lambda p: os.path.basename(p).lower())
        files.chain = list(reversed(found))
        elemental.apply(files, payload, elemental.load_manifest(), report, want_icons=args.icons)
        forged.apply(files, payload, forged.load_manifest(), report)

    for line in report:
        print(line)
    mpq.write_archive(args.out, payload)
    print("wrote %s: %d files" % (args.out, len(payload)))
    for name in sorted(payload):
        print("  ", name, len(payload[name]))


if __name__ == "__main__":
    main()
