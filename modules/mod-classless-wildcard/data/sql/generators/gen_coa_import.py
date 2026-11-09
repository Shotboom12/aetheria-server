#!/usr/bin/env python3
"""Conquest of Azeroth class kits for the classless library.

Reads the CoA client's own tables and the CoA core's rank progression, and
writes three things:

  * a coverage manifest: every one of the 21 classes' advancement entries,
    what it needs from the engine, whether its spell ids are free in Esteria,
    and what this import did with it;
  * data/sql/generated/cw_spells_coa.sql for the entries that are switched on:
    their spell rows, rank chains, the synthetic talent rows the talent grant
    path needs, and the module's own catalog tables;
  * client-patch/coa_manifest.json, which build_coa_patch.py turns into the
    client archive carrying the same spells and icons.

Nothing of CoA's is stored in the repository except what the SQL needs to run
the server: the client builder copies its rows out of the CoA client again.

Reviewed entries whose engine and script dependencies are implemented are switched on.
Every withheld entry remains in the manifest with its blocking reasons.

  python gen_coa_import.py --coa-client G:/CoAClient/Client \
      --coa-core R:/.../azerothcore-wotlk-coa --target-client "G:/3.3.5a - Dev" \
      --server-spell-dbc .../retroported-races/Spell.dbc \
      --world-spell-ids ids.txt --coverage out.json
"""
import argparse
import json
import os
import re
import struct
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
MODULE = os.path.normpath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(MODULE, "client-patch"))
from lib import coa, coa_racials  # noqa: E402

SEP = "\\"

# Switched on: every candidate (stock mechanics only, ids free, nothing in the
# CoA code depends on it) that needs no other entry. The pilot pair proved the
# two shapes everything is built from: Brutal Swing, a CoA Talent whose spell
# ranks up with level, is an ability line (the rule the library applies to
# Mortal Strike); Savage Strength, ranked per point, is a talent.
PILOT_ENTRIES = (34268, 34277)

# Support-only CoA spells used by registered scripts or linked-spell relations.
# They are not advancement entries, but the paired client/server Spell.dbc
# import must carry them so exact upstream bindings and helper links can load.
EXPLICIT_SUPPORT_SPELLS = {
    301005, 572904,
    504635, 524969, 560971, 560972, 561087, 562722, 563124, 570270, 573076,
    653216, 653275, 681187, 800046, 801615, 803349, 805161, 807310, 807358, 807637, 808090,
}

# IMPORTANT: The sets below are upstream import assumptions, not proof that this
# Aetheria preview implements those effects. The active core currently dispatches
# multiple listed effect IDs to EffectNULL and has lower pre-load limits for other
# listed IDs. Do not treat generator coverage as runtime readiness; see
# checks/hero-spell-effect-dispatch-gap-20261107.json and
# checks/hero-spell-effect-preload-compatibility-20261107.json.
# Esteria's highest declared effect and aura (SharedDefines.h TOTAL_SPELL_EFFECTS
# and TOTAL_AURAS). Anything at or past them has no handler here.
TARGET_EFFECTS = 165
TARGET_AURAS = 317
# Legacy upstream coverage assumptions retained for reproducibility. These sets
# must be reconciled against Aetheria core and Hero-only script behavior before
# treating the generated catalog as functional or deployment-ready.
IMPLEMENTED_EFFECTS = {165, 166, 168, 169, 187, 171, 173, 174, 175, 176, 177, 178, 181, 183, 184, 190, 192, 193, 195, 197}
IMPLEMENTED_AURAS = {327, 328, 317, 319, 330, 333, 336, 337, 338, 340, 344, 345, 348, 350, 351, 357, 360}
# Auras that a kit's ported contracts turn into a dummy aura at load, or whose scripts hook: only in those
# families (a spell's family is its class + 6). 354 is CoA's proc-event aura; 353 is turned into a dummy by the
# Witch Doctor and Stormbringer contracts; 347 by the Barbarian, Xoroth, Necromancer, Pyromancer and Tinker ones,
# and only for a spell the ported code names.
CONVERTED_AURA_FAMILIES = {
    354: {18, 19, 20, 22, 23, 25, 26, 29, 30, 32, 33, 34, 35},
    353: {19, 22},
    347: {18, 23, 29, 30, 34},
}
CONVERTED_AURA_NAMED_ONLY = {347}
# Ranger (27) and Primalist (37) scripts hook their own aura 354 spells directly, so no contract rewrites them;
# a 354 spell is allowed there only when the ported code names its id.
NAMED_AURA_FAMILIES = {354: {27, 36, 37, 38}}
# CoA's own core leaves these auras without a handler and its kit code reads them from scripts or rewrites them at
# load (AscensionXContracts.cpp), so a spell of any kit's family carrying one is as good as CoA's when ported code
# names it or a ported script is bound to it. 337 (override spell) is read by Player::HasActiveSpell here too.
PROC_CARRIER_AURAS = {341, 347, 349, 353, 354}
KIT_FAMILIES = set(range(18, 39))
# entries that take clone ids for their rank spells (the ids are in lib/coa.py CLONES)
ENTRY_RANK_CLONES = {7131: {503748: 14000005, 504888: 14000006}}
SCRIPT_BOUND = set()   # spells CoA's SQL binds to a script the module ports (filled in main)
# one-off: Eternal Presence has family 21 but belongs to a Bloodmage entry whose script hooks aura 354
# Witch Hunter contracts dummy 354 only on Flames 803422 and Vampiric Tonic 802276
CONVERTED_AURA_SPELLS = {354: {560001, 803422, 802276}}
# Decoder's proc aura (706523) has a custom AuraScript that calls
# PreventDefaultAction before it can trigger 707152. The helper has no other
# caller; its stock aura:354 behavior is therefore unreachable when Decoder's
# reviewed script binding is present. Keep this separate from converted auras:
# this records a suppressed DBC helper, not a runtime implementation of 707152.
SUPPRESSED_AURA_TRIGGER_HELPERS = {707152: 706523}
SPELL_MOD_AURAS = (107, 108)   # flat and percent spell modifiers
# SpellModOp 0-30 is client-facing; 31 is CoA's server-side SPELLMOD_MAX_AURA_STACKS.
MAX_SPELLMOD_OP = 31
HERO_SKILL_LINE = 990
HERO_CLASS_MASK = 1 << 9  # class 10 is bit 9 in SkillLineAbility.dbc
# Keep paired custom racial SkillLineAbility rows aligned with the actual
# GetRaceMaskForRace() compatibility mapping in SharedDefines.h. Exact access
# still uses race_id metadata because several races deliberately share a bit.
RACE_MASK_ALIAS = {
    75: 1, 77: 1, 74: 2, 76: 2, 78: 2, 60: 11, 61: 5, 46: 6, 47: 7, 50: 4, 51: 8, 52: 24,
    53: 10, 54: 10, 55: 3, 56: 1, 63: 2, 68: 2, 70: 2, 71: 2, 69: 1, 72: 1, 62: 1, 65: 1,
    67: 1, 64: 2, 66: 2,
}
# CoA core commit 0ad3b812 guards and ignores out-of-range ops. Preserve that exact behavior only for
# Sharpshooter effect 1: its supported effect 0 still increases the selected Ranger spells by 24%.
UPSTREAM_IGNORED_SPELLMOD_OPS = {(582855, 1, 45)}
# These two exact effect shapes are rewritten by reviewed SpellInfo contracts before AuraEffects are built.
# Verify the full source contract at import time so a stale exception cannot survive a later source edit.
SPELLMOD_RANGE_CONTRACT_SOURCES = {
    (704175, 1, 40): (
        os.path.join(MODULE, "src", "coa", "AscensionTemplarContracts.cpp"),
        ("if (id == 704175 && info->Effects[1].Effect == SPELL_EFFECT_APPLY_AURA && "
         "info->Effects[1].ApplyAuraName == SPELL_AURA_ADD_PCT_MODIFIER && "
         "info->Effects[1].MiscValue == 40 && info->Effects[1].BasePoints == -1 && "
         "info->Effects[1].SpellClassMask == flag96(4194304, 0, 0)) info->Effects[1].Effect = 0;",),
    ),
    (807544, 1, 40): (
        os.path.join(MODULE, "src", "coa", "AscensionBloodmageTalents.cpp"),
        ("constexpr uint32 SPELL_THE_CUP_RUNNETH_OVER = 807544;",
         "if (info->Id == SPELL_THE_CUP_RUNNETH_OVER && "
         "bloodmoonModifier.Effect == SPELL_EFFECT_APPLY_AURA && "
         "bloodmoonModifier.ApplyAuraName == SPELL_AURA_ADD_PCT_MODIFIER && "
         "bloodmoonModifier.BasePoints == 19 && "
         "bloodmoonModifier.MiscValue == SPELLMOD_BONUS_MULTIPLIER && "
         "bloodmoonModifier.SpellClassMask[0] == 0 && "
         "bloodmoonModifier.SpellClassMask[1] == 139264 && "
         "bloodmoonModifier.SpellClassMask[2] == 0 && "
         "tormentModifier.Effect == SPELL_EFFECT_APPLY_AURA && "
         "tormentModifier.ApplyAuraName == SPELL_AURA_ADD_PCT_MODIFIER && "
         "tormentModifier.BasePoints == 19 && tormentModifier.MiscValue == 40 && "
         "tormentModifier.SpellClassMask[0] == 0 && "
         "tormentModifier.SpellClassMask[1] == 0 && "
         "tormentModifier.SpellClassMask[2] == 2097152) tormentModifier.Effect = 0;"),
    ),
}

def source_has_normalized_contract(path, expected_fragments):
    try:
        with open(path, encoding="utf-8") as contract_source:
            normalized = re.sub(r"\s+", " ", contract_source.read())
    except OSError:
        return False
    return all(fragment in normalized for fragment in expected_fragments)

CONTRACTED_OUT_OF_RANGE_SPELLMODS = {
    contract for contract, (path, expected) in SPELLMOD_RANGE_CONTRACT_SOURCES.items()
    if source_has_normalized_contract(path, expected)
}
SPELLMOD_RANGE_GUARD = os.path.normpath(os.path.join(
    MODULE, "..", "..", "core-patch-source", "src", "server", "game", "Spells", "Auras", "SpellAuraEffects.cpp"))
try:
    with open(SPELLMOD_RANGE_GUARD, encoding="utf-8") as guard_source:
        SPELLMOD_RANGE_GUARD_AVAILABLE = \
            "GetMiscValue() < 0 || GetMiscValue() >= MAX_SPELLMOD" in guard_source.read()
except OSError:
    SPELLMOD_RANGE_GUARD_AVAILABLE = False
F_MISC_VALUE, F_CLASS_MASK = 110, 122
# Modifier spells CoA's SpellAffect.dbc names targets for: a modifier with an empty class mask is routed by that
# table (SpellInfo::SpellAffectTargets in CoA's core), which this core does not read yet.
SPELL_AFFECT_MODIFIERS = set()
STOCK_POWERS = (0, 1, 3, 0xFFFFFFFE)

# Native ids the import owns. Advancement ids are not safe talent ids, so each
# entry maps to a fixed offset of its own; tabs are per class and slot.
TALENT_ID_BASE = 100000
TAB_ID_BASE = 2000
SHARED_CLASS_TAB = 87
HIDDEN_TAB_CLASS_MASK = 2048    # bit 11: no real class, exactly as the Hero tab

# Spell.dbc 3.3.5a columns used here
F_ATTR, F_EQUIP_INV = 4, 70
F_TRIGGER, F_EFFECT, F_AURA = 116, 71, 95
F_VISUAL, F_ICON, F_ACTIVE_ICON = 131, 133, 134
F_NAME, F_POWER, F_COST, F_FAMILY = 136, 41, 42, 208
F_BONUS_MULTIPLIER = (229, 230, 231)
STRING_COLUMNS = set(range(136, 152)) | set(range(153, 169)) | set(range(170, 186)) | set(range(187, 203))
FLOAT_COLUMNS = {47, 77, 78, 79, 101, 102, 103, 119, 120, 121, 216, 217, 218, 229, 230, 231}

# Higher ranks whose own weapon subclasses contradict their slot mask; the CoA
# core clears the slot mask at load (AscensionBarbarian.cpp). Done here in the
# data, for client and server alike.
CLEAR_EQUIP_SLOT = set(range(500996, 501003)) | set(range(806905, 806909))

# Spells the CoA code names whose every mention was read and needs no port:
# Brutal Swing's ranks appear only in the slot fix above and in Relentless's
# check of which spell critted, which is Relentless's behaviour, not theirs.
# 802735-802737 are Guardian Centurion Strike ranks that ported code names as the range 802734-802738
# 520465's only behavior is the Mineralization SpellInfo contract, ported in CoAGluePrimalist.cpp.
# 680862's only behavior is the Stone Tosser modifier contract, ported in CoAGluePrimalist.cpp.
# 800041's only behavior is the Wild Carnage modifier contract, ported in CoAGluePrimalist.cpp.
# 555724's only behavior is the Precision school-mask contract, ported in CoAGluePrimalist.cpp.
# 706345's only behavior is the Heavy Handed metadata contract, ported in CoAGluePrimalist.cpp.
# 804664's only behavior is the Fae Dust stealth-detection mask, ported in CoAGluePrimalist.cpp.
# 707514's only behavior is the Earthmother Warden class-mask bit, ported in CoAGluePrimalist.cpp.
# 706148's only behavior is the Grove Tender class-mask bit, ported in CoAGluePrimalist.cpp.
# 300868's only behavior is the Ride the Wave target correction, ported in CoAGluePrimalist.cpp.
# 803514 and 807559's only behaviors are the Douse metadata contracts in CoAGluePrimalist.cpp.
# 505208's only behavior is the Grove Guardian Allies target correction in CoAGluePrimalist.cpp.
# 706174's only behavior is the Magmatism aura-state contract in CoAGluePrimalist.cpp.
# 300691's only behavior is the Rush of the Hunt aura-state contract in CoAGluePrimalist.cpp.
# 560313's periodic base-value hook is ported with Hero/owned-Primalist-kit gating in AscensionPrimalistTorn.cpp.
# 520468/520469/520729's Shattering hit proc is ported with Hero/owned-kit gating in AscensionPrimalistShattering.cpp.
# 500302/520841/525015's Emerald Will dispel proc is ported with Hero/owned-kit gating in its module script.
# 680439's Earthshaping hooks are ported with Hero/owned-kit gating in AscensionPrimalistEarthshaping.cpp.
# 706176/806048/806549 Ursoc-form behavior is Hero/owned-kit-gated; form metadata is guarded by the DBC layout.
# 806559/806561/806562 Rexxar Might behavior is Hero/owned-kit-gated; ready-aura metadata is row-guarded.
# 504229's Primal Totem summon is registered with a Hero/owned-kit gate and exact summon-row validation.
# 572853/806536/802888/572826/572830 spirit summons, owner proc and scaling are Hero/owned-kit gated.
# 300695/573215/706201/680406/680472/806068 mountain triggers are Hero-gated; Earths Rage metadata is DBC-row guarded.
# 500692 Boulder Dash cast-lock behavior is Hero/owned-Primalist gated; linked helpers and coefficient are staged.
# 806552/806553/806554/806378 Bones behavior is current-pet and Hero/owned-Primalist gated.
# 300697/301353 Crushing Earth helper-aura behavior is Hero/owned-Primalist gated.
# 500935/500939/500943/800137/504856 and linked Boon helpers require Hero/owned-Primalist/current-pet gates.
# Quaking Thane and Thane's Rage are Hero/owned-Primalist gated; metadata row is guarded.
# 504446/524972 Earthmother Pendant proc and self-heal are Hero/owned-Primalist gated.
# 560510/302534/302590 Journey delayed bursts and proc recheck Hero/owned-Primalist eligibility.
# 805867 Dreamslip uses a guarded native pacify/silence row and Hero/owned-Primalist runtime gate.
# 807467/537250/537252 Neptulon's Wrath AP forwarding and proc require Hero/owned-Primalist gates.
# 707367/707369 Spiritual Frenzy procs and cleave require Hero/owned-Primalist/current-pet gates.
# 707616/680421/680427 Mountain Avatar behavior is Hero/owned-Primalist gated; helper metadata is row-guarded.
# 706340/523526/523527 Empowered Boons proc/helpers are Hero/owned-Primalist gated.
# 803980/810040 Wildheart cooldown reduction and recovery are Hero/owned-Primalist gated.
# 537218/801242/704098 Primal Weapons selector and weapon auras use the Hero-owned Primalist eligibility path.
# 681078 Pooled Vitality is consumed by the registered Bloodmage AllSpellScript; its eligibility path requires
# the Hero-owned Son of Arugal kit before it marks or changes a spell cast.
SCRIPT_REVIEWED = {537218, 801242, 704098, 563262, 806070, 806071, 803980, 810040, 807249, 706340, 523524, 523523, 523526, 523527, 505220, 707616, 680421, 680427, 680673, 707367, 707369, 807467, 537250, 537252, 573255, 805867, 804315, 560510, 302534, 302590, 504446, 524972, 561193, 804124, 803974, 681130, 503267, 503268, 504571, 505155, 505156, 505157, 520463, 681420, 681421, 681422, 681423, 681424, 500935, 500939, 500943, 800137, 504856, 800181, 801234, 997800, 505217, 300697, 301353, 806552, 806553, 806554, 806378, 500692, 500693, 680473, 681302, 300744, 301203, 572029, 560306, 800144, 500696, 500937, 547213, 500945, 800178, 301087, 562312, 574323, 680445, 681380, 301306, 301307, 561037, 500615, 681357, 706138, 706167, 707806, 303014, 303030, 560157, 560179, 504222, 504874, 707560, 560154, 560155, 520696, 680448, 707173, 503630, 520134, 560298, 680412, 802595, 802596, 520466, 520468, 300698, 680442, 803981, 807120, 807859, 712433, 300728, 680421, 800094, 503630, 503716, 806185, 807724, 806186, 807434, 680444, 680445, 681380, 680442, 681280, 800141, 521233, 521231, 805336, 300691, 300695, 300868, 500302, 500913, 520465, 520468, 520469, 520729, 520841, 525015, 555724, 560313, 572826, 572830, 572853, 573215, 680406, 680439, 680472, 680862, 706148, 706174, 706201, 706345, 706176, 707514, 800041, 802888, 803514, 804664, 806048, 806068, 806536, 806549, 806559, 806561, 806562, 800179, 800180, 504229, 505208, 807559} | set(range(500996, 501003)) | {802735, 802736, 802737}
# 521452 is the native DBC "Energize +5 Rage" effect. Spiritbound triggers it directly
# from its own DBC row; the separate Fleshwarden event that also casts it remains gated
# by its own unported source IDs and is not implied by this shared helper.
SCRIPT_REVIEWED.add(521452)
# Minion capacity cost is implemented by AscensionNecromancer::Cost (the
# selected Necromancer runtime is Hero/owned-kit gated); ResourceQuery.h only
# documents the read-only query API and must not make this spell look unported.
SCRIPT_REVIEWED.add(500331)

# 800432's Cultist aura lifecycle is registered by AddSC_AscensionCultistAuras,
# bound by the staged Aetheria migration, and every runtime path resolves its
# caster through AscensionCultist::Owner (Hero plus owned Cultist kit).
SCRIPT_REVIEWED.add(800432)

# Reclamation's only selected-core references are these exact rank spells in
# AscensionCompat.cpp's RANGED_PREPARATION_CLIENT_SPELLS list for client row
# delivery. The paired CoA import manifest supplies the same rows; no separate
# server gameplay script is required by these references.
SCRIPT_REVIEWED.update({572343, 572344, 572345, 572383, 680902, 680903, 680904, 680905, 806288})

# These Bloodmage IDs appear in AscensionPooledVitality.h as empowerment labels
# or pooled-vitality constants. Their runtime consumers are staged in the
# Hero/owned-kit-gated BloodShards, Secondary, Talents, and Vitality scripts;
# the header's separate Cursed Form compatibility markers 524861/802877 are
# intentionally not reviewed here.
SCRIPT_REVIEWED.update({504129, 504282, 680687, 681026, 520314, 520836, 520838,
                        572895, 572898, 807563, 563736, 801952, 705734, 681078})

# Spells whose ported code is fenced off (#ifdef ESTERIA_COA_*) because it
# needs an engine feature this realm does not have yet. Entries containing
# them stay blocked under that reason until the feature lands.
UNPORTED_ENGINE = {
}

# CharacterAdvancement.dbc, the fields AscensionCoATalentData.cpp reads
CA_ID, CA_TYPE, CA_REQUIRED, CA_SPELLS = 0, 1, 2, 5
CA_AE, CA_TE, CA_LEVEL, CA_GROUP, CA_CLASS_TYPE, CA_TAB = 14, 15, 26, 29, 32, 33
CA_TAB_AE, CA_TAB_TE = 38, 39
SPEC_PRIMARY_STAT, SPEC_SIGNATURE, SPEC_IDENTITY, SPEC_NAME = 8, 24, 28, 29


class Dbc:
    def __init__(self, data):
        magic, self.n, self.fields, self.size, _ = struct.unpack_from("<4s4I", data)
        if magic != b"WDBC":
            raise ValueError("not a WDBC table")
        self.data = data
        self.strings = data[20 + self.n * self.size:]
        self.index = {self.u(i, 0): i for i in range(self.n)}

    def u(self, row, col):
        return struct.unpack_from("<I", self.data, 20 + row * self.size + col * 4)[0]

    def s(self, row, col):
        off = self.u(row, col)
        return self.strings[off:self.strings.index(b"\0", off)].decode("utf-8", "replace")

    def raw(self, row):
        return self.data[20 + row * self.size:20 + (row + 1) * self.size]


def read_table(archives, table):
    _path, data = coa.winning_file(archives, "DBFilesClient" + SEP + table + ".dbc")
    if data is None:
        raise SystemExit("no archive carries %s.dbc" % table)
    return data


def load_progression(core):
    """{first spell: [(rank spell, level), ...]} from AscensionSpellProgressionData.h."""
    text = open(os.path.join(core, "src", "server", "coa", "AscensionSpellProgressionData.h"),
                encoding="utf-8").read()
    chains = {}
    for cls, first, spell, level in re.findall(r"\{\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\s*\}", text):
        chains.setdefault(int(first), []).append((int(spell), int(level)))
    for ranks in chains.values():
        ranks.sort(key=lambda r: r[1])
    return chains


# CoA files that name spells without giving them behaviour: test scenarios,
# release history, acquisition lists. A mention there blocks nothing.
INERT_FILES = re.compile(r"Contract|Changelog|Collect|Manastorm|CustomClassData|LiveBaseline|Catalog|Checkpoint")
# Generic tables carried across as data (AscensionStockCoefficients.cpp zeroes
# the listed spells' coefficients; AscensionScalingBase.cpp curves the listed
# effects' base points by level, ported as cw_coa_spell_scaling).
STOCK_COEFFICIENT_FILE = "AscensionStockCoefficientData.h"
SCALING_FILE = "AscensionScalingBaseData.h"
# "learning X also teaches Y", carried as spell_learn_spell
TAUGHT_FILE = "AscensionTaughtAbilityData.h"
# CoA code that has no meaning here (AscensionAuraAmounts is ported: it sends on 0x535, SMSG_ESTERIA_AURA_AMOUNT).
# AscensionRunePouches.cpp opens pouches of CoA's Rune of Ascension currency item, which Esteria does not have;
# the pouch item ids only collide with a few spell ids. AscensionSummonAvoidance.cpp keeps CoA summons out of
# harm's way and is ported (CoAGlue registers it); the NPC ids it lists only collide with Reaper spell ids.
# CoADungeonBossSpells.cpp is what dungeon bosses cast (its scripts act only for creature casters); the spells it
# names that a kit shares (Sun Cleric Divine Retribution) behave for a player as their data says.
NOT_APPLICABLE_FILES = {"AscensionRunePouches.cpp",
                        "AscensionSummonAvoidance.cpp", "CoADungeonBossSpells.cpp"}
# CoA files this module carries split up and rewritten rather than copied (AscensionClassMechanics.cpp became
# the 12To17, 19To25 and 26To32 slices and the CoAGlue<Class> files). A spell they name still counts as
# unported when no ported code mentions its id.
COUNTED_DATA = {"AscensionCustomResourceData.h", "AscensionTalentReplacementData.h"}
SPLIT_PORTED_FILES = {"AscensionClassMechanics.cpp", "AscensionCompat.cpp"}
# Explicit behaviors completed in the focused Primalist Secondary adapter;
# other IDs mentioned in that CoA source must retain their blockers.
PRIMALIST_SECONDARY_PORTED_NUMBERS = {
    572873, 572874, 572875, 572876, 572877, 572878, 572908,
    805462, 805919, 803973, 806073, 807466, 807561, 807651,
    # The focused UnitScript implements these exact aura lifecycle effects.
    805105, 806143,
    # Totem Warrior is ported with its two exact source bindings and Hero-owned gates.
    555732, 704099, 500939, 800140, 504240,
    # Volcanic Blast copies resolved critical damage through the focused Hero AuraScript.
    680451, 681353, 681480,
    # Cracking Earth counts successful Volcanic Blast hits and manages its five-hit stack aura.
    560145, 560146,
    # Stone Grip requires only the exact DBC mechanic/effect correction in the focused metadata hook.
    800145,
}
# The Primalist branch in this shared file is implemented by the Hero-gated
# HandleAscensionPrimalistCaveInInterrupt adapter; other class mechanics stay blocked.
CLASS_MECHANICS_26_TO_32_PORTED_NUMBERS = {500615, 680441}
# Ranger Talents is selected and registered as one source unit. Its spell
# handlers and shared cast helpers have been reviewed and gated to Hero-owned
# Ranger kits; these are the spell ids whose source-backed behavior is present.
RANGER_TALENTS_PORTED_NUMBERS = {
    500075, 520492, 520558, 520571, 520880, 524653, 524654, 532261,
    560965, 561161, 680276, 680278, 681292, 681394, 705028, 705063,
    705074, 705087, 706762, 800077, 800578, 801472, 802036, 803115,
    803123, 804329, 804457, 806368,
}
PARTIAL_PORTED_FILES = {"AscensionRangerTalents.cpp"}
# Entries of a class whose package is not ported (Felsworn, Reaper, Chronomancer, Runemaster) that only a file
# ported for another class's sake would have cleared: AscensionResourceTalents.cpp and the talent replacement
# table carry Felsworn, Reaper and Chronomancer rows whose resource service and abilities are not here.
HELD_KIT_ENTRIES = set()
PORT_DIR = os.path.join(MODULE, "src", "coa")


# A copied file alone does not establish a working class package. These packages
# have explicit registration and contract entry points in CoAGlue.cpp.
WIRED_PACKAGES = {
    "WitchHunter": "AddCoAWitchHunterPackage", "Guardian": "AddCoAGuardianPackage",
    "Ranger": "AddCoARangerPackage", "Cultist": "AddCoACultistPackage", "Primalist": "AddCoAPrimalistPackage",
}


def ported_files():
    names = {n for n in os.listdir(PORT_DIR) if n.startswith("Ascension") and n.endswith((".cpp", ".h"))}
    glue = open(os.path.join(PORT_DIR, "CoAGlue.cpp"), encoding="utf-8").read()
    for package, entry in WIRED_PACKAGES.items():
        if not re.search(r"^    " + entry + r"\(\);", glue, re.M):
            names = {n for n in names if not n.startswith("Ascension" + package)}
    return names


def script_helpers(spell):
    """Spells the ported code casts or checks by id. Nothing in the spell data
    points at most of them (an energize a talent's script casts), so without
    this they would be missing and the cast would silently do nothing."""
    out = set()
    for name in ported_files():
        text = open(os.path.join(PORT_DIR, name), encoding="utf-8", errors="replace").read()
        out.update(int(x) for x in re.findall(r"\b(\d{5,7})\b", text) if int(x) in spell.index)
    # a number in the code that happens to match a stock spell id (a creature,
    # an item) is not a helper: keep CoA's own range and class families
    return {s for s in out if (s >= 300000 or spell.u(spell.index[s], F_FAMILY) >= 18) and well_formed(spell, s)}


def well_formed(spell, sid):
    """A row whose string offsets all land inside the string block."""
    row = spell.index[sid]
    return all(spell.u(row, c) < len(spell.strings) for c in STRING_COLUMNS)


def script_bound_spells(spell, core):
    """Spells CoA's world updates bind to a script this module ports (spell_script_names). The
    script is inert without its spell; nothing in the spell data or the ported code's numbers
    reaches most of them (a spell granted by CoA's class tables, a child of a scripted spell)."""
    names = set()
    for name in os.listdir(PORT_DIR):
        if name.endswith(".cpp") and (not name.startswith("Ascension") or name in ported_files()):
            text = open(os.path.join(PORT_DIR, name), encoding="utf-8", errors="replace").read()
            names.update(re.findall(r"RegisterSpell\w*\(\s*(\w+)", text))
            names.update(re.findall(r"RegisterSpellScriptWithArgs\(\s*\w+\s*,\s*\"(\w+)\"", text))
    out = set()
    root = os.path.join(core, "data", "sql", "updates")
    for folder in ("db_world", "pending_db_world"):
        for fname in sorted(os.listdir(os.path.join(root, folder))):
            if not fname.endswith(".sql"):
                continue
            text = open(os.path.join(root, folder, fname), encoding="utf-8", errors="replace").read()
            for sid, script in re.findall(r"\(\s*(-?\d+)\s*,\s*'(\w+)'\s*\)", text):
                if script in names and abs(int(sid)) in spell.index and well_formed(spell, abs(int(sid))):
                    out.add(abs(int(sid)))
    return out


def load_taught(core):
    """[(parent spell, taught spell)] from AscensionTaughtAbilityData.h."""
    text = open(os.path.join(core, "src", "server", "coa", TAUGHT_FILE), encoding="utf-8").read()
    rows = re.findall(r"\{\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\s*\}", text)
    return [(int(parent), int(child)) for _cls, _spec, _lvl, parent, child in rows]


TEAM_ALLIANCE, TEAM_HORDE, TEAM_ANY = 0, 1, 2     # TeamId
BASELINE_ENTRY = 3000000000     # cw_coa_automatic entry ids of baseline rows: never a CharacterAdvancement id
# Felsworn rifts to capital cities, by the faction their SkillLineAbility.RaceMask allows (1101 Alliance,
# 690 Horde). CoA gates them by race; Esteria's Heroes include races CoA has no mask for, so they go by faction.
# 535602 (Stonard) is never granted in CoA and has no destination in AscensionFelswornData.h.
RIFT_TEAMS = {535595: TEAM_ALLIANCE, 535596: TEAM_ALLIANCE, 535597: TEAM_ALLIANCE, 535601: TEAM_ALLIANCE,
              535598: TEAM_HORDE, 535599: TEAM_HORDE, 535600: TEAM_HORDE}


def class_baseline(core):
    """[(class, level, spell, baseline, team)]: CoA's ClassSpells rows (baseline 1) and the Felsworn rifts
    (baseline 0, so they follow the automatic-entry switch): the Alliance ones are ClassSpells rows, the Horde
    ones AscensionCompat.cpp's FelswornHordeCapitalRifts."""
    coa_dir = os.path.join(core, "src", "server", "coa")
    text = open(os.path.join(coa_dir, "AscensionCustomClassData.h"), encoding="utf-8").read()
    body = re.search(r"\bClassSpells\s*=\s*\{\{(.*?)\}\};", text, re.S).group(1)
    rows = [tuple(int(x) for x in m) for m in re.findall(r"\{\s*(\d+),\s*(\d+),\s*(\d+)\s*\}", body)]
    compat = open(os.path.join(coa_dir, "AscensionCompat.cpp"), encoding="utf-8").read()
    horde = re.search(r"FelswornHordeCapitalRifts\s*=\s*\{\{(.*?)\}\};", compat, re.S).group(1)
    rows += [(14, int(level), int(sid)) for sid, level in re.findall(r"\{\s*(\d+),\s*(\d+)\s*\}", horde)]
    assert rows and all(sid in RIFT_TEAMS for _c, _l, sid in rows[-3:]), "CoA rift tables changed shape"
    return [(cls, level, sid, 0 if sid in RIFT_TEAMS else 1, RIFT_TEAMS.get(sid, TEAM_ANY))
            for cls, level, sid in rows]


def load_scripted(core):
    """Spell ids the CoA class code names, and the two generic tables.

    A spell named in class code has behaviour the data alone does not carry, so
    it is not imported without that code. Returns (scripted ids, ids whose
    coefficient CoA zeroes, {id: scaled effect mask}); the first is a dict of
    id -> the files naming it, which is the porting worklist."""
    ids = {}
    root = os.path.join(core, "src", "server", "coa")
    for name in sorted(os.listdir(root)):
        if not name.endswith((".cpp", ".h")) or "Progression" in name or INERT_FILES.search(name) \
                or name in (STOCK_COEFFICIENT_FILE, SCALING_FILE, TAUGHT_FILE) \
                or (name in ported_files() and name not in PARTIAL_PORTED_FILES) \
                or name in NOT_APPLICABLE_FILES:
            continue
        text = open(os.path.join(root, name), encoding="utf-8", errors="replace").read()
        if name == "AscensionPrimalistSecondary.cpp":
            # Only the explicitly ported independent handlers are covered; the
            # original file also contains mechanics that remain unported.
            code = PRIMALIST_SECONDARY_PORTED_NUMBERS
        elif name == "AscensionClassMechanics26To32.cpp":
            code = CLASS_MECHANICS_26_TO_32_PORTED_NUMBERS
        elif name == "AscensionRangerTalents.cpp":
            code = RANGER_TALENTS_PORTED_NUMBERS
        else:
            code = ported_code_numbers() if name in SPLIT_PORTED_FILES else ()
        for x in set(re.findall(r"\b(\d{5,7})\b", text)):
            if int(x) not in code:
                ids.setdefault(int(x), []).append(name)
    stock = open(os.path.join(root, STOCK_COEFFICIENT_FILE), encoding="utf-8").read()
    stock_ids = {int(x) for x in re.findall(r"\b(\d{5,7})\b", stock.split("=", 1)[1])}
    scaling = open(os.path.join(root, SCALING_FILE), encoding="utf-8").read()
    scaled = {int(s): int(m) for s, m in re.findall(r"\{\s*(\d+),\s*(\d+)\s*\}", scaling)}
    return ids, stock_ids, scaled


def join_entries(tables):
    """The CoA core's own join (AscensionCoATalentData.cpp LoadCoATalentData)."""
    classes, ctypes, tabtypes, specs, adv = (tables[k] for k in
                                             ("ChrClasses", "CharacterAdvancementClassTypes",
                                              "CharacterAdvancementTabTypes", "ChrSpecs",
                                              "CharacterAdvancement"))
    class_token = {classes.u(r, 0): classes.s(r, 55) for r in range(classes.n)}
    class_name = {classes.u(r, 0): classes.s(r, 4) for r in range(classes.n)}
    ctype = {ctypes.u(r, 0): (ctypes.u(r, 2), ctypes.u(r, 4) != 0) for r in range(ctypes.n)}
    tab_token = {tabtypes.u(r, 0): tabtypes.s(r, 1).upper() for r in range(tabtypes.n)}
    spec_by = {}
    spec_info = {}
    for r in range(specs.n):
        sid = specs.u(r, 0)
        key = (specs.s(r, 1), specs.s(r, 2).upper())
        spec_by[key] = sid
        spec_info[sid] = dict(id=sid, token=specs.s(r, 2), name=specs.s(r, SPEC_NAME),
                              identity=specs.u(r, SPEC_IDENTITY), signature=specs.u(r, SPEC_SIGNATURE))
    entries = []
    for r in range(adv.n):
        cls, custom = ctype.get(adv.u(r, CA_CLASS_TYPE), (0, False))
        if not custom or not 12 <= cls <= 32:
            continue
        tab = adv.u(r, CA_TAB)
        spec = 0
        if tab != SHARED_CLASS_TAB:
            spec = spec_by.get((class_token[cls], tab_token.get(tab, "")))
            if spec is None:
                continue
        ranks = [adv.u(r, CA_SPELLS + i) for i in range(5) if adv.u(r, CA_SPELLS + i)]
        entries.append(dict(
            id=adv.u(r, CA_ID), cls=cls, spec=spec, tab=tab, type=adv.s(r, CA_TYPE), ranks=ranks,
            ae=adv.u(r, CA_AE), te=adv.u(r, CA_TE), level=adv.u(r, CA_LEVEL),
            requires=[adv.u(r, CA_REQUIRED + i) for i in range(3) if adv.u(r, CA_REQUIRED + i)],
            group=adv.u(r, CA_GROUP), tab_ae=adv.u(r, CA_TAB_AE), tab_te=adv.u(r, CA_TAB_TE)))
    entries.sort(key=lambda e: e["id"])
    used_specs = {e["spec"] for e in entries if e["spec"]}
    return entries, {c: class_name[c] for c in sorted({e["cls"] for e in entries})}, \
        {s: spec_info[s] for s in sorted(used_specs)}


def load_budgets(essence):
    """{class: [(level, AE, TE)]}: the essence a CoA character of that class
    has by each level (AscensionCoATalentData.cpp's CoATalentBudgets)."""
    out = {}
    for r in range(essence.n):
        cls, level = essence.u(r, 2), essence.u(r, 1)
        if not 12 <= cls <= 32 or not level or any(essence.u(r, c) for c in range(3, 7)):
            continue
        out.setdefault(cls, []).append((level, essence.u(r, 7), essence.u(r, 8)))
    for rows in out.values():
        rows.sort()
    return out


def investment_level(budgets, e):
    """CoA gates a tree entry on essence already spent in that tree. The Hero
    spends from one pool across every tree, so the gate becomes the first
    level at which a CoA character could have spent that much."""
    level = e["level"]
    need_ae, need_te = e["tab_ae"], e["tab_te"]
    if need_ae or need_te:
        reach = [lv for lv, ae, te in budgets.get(e["cls"], []) if ae >= need_ae and te >= need_te]
        level = max(level, reach[0] if reach else 80)
    return level


def closure(spell, root, chains):
    """The entry's own spells: its ranks, their level progression, and what they trigger."""
    out, todo = [], list(root)
    for first in root:
        todo += [s for s, _lvl in chains.get(first, [])]
    while todo:
        sid = todo.pop()
        if sid in out or sid not in spell.index:
            continue
        out.append(sid)
        row = spell.index[sid]
        todo += [spell.u(row, F_TRIGGER + i) for i in range(3) if spell.u(row, F_TRIGGER + i)]
    return sorted(out)


_PORTED_NUMBERS = []


def ported_numbers():
    """Every number the ported code writes: the spells it names."""
    if not _PORTED_NUMBERS:
        found = set()
        for name in ported_files():
            text = open(os.path.join(PORT_DIR, name), encoding="utf-8", errors="replace").read()
            found.update(int(x) for x in re.findall(r"\b(\d{5,7})\b", text))
        found |= ported_code_numbers()   # the CoAGlue files carry rewritten CoA code too
        _PORTED_NUMBERS.append(found)
    return _PORTED_NUMBERS[0]


def ported_code_numbers():
    """Spell ids that ported code (not the data tables) names, in src/coa and its CoAGlue files."""
    found = set()
    for name in os.listdir(PORT_DIR):
        # these tables count: CoAResourceService.cpp and CoAGlueReplacements.cpp run their rows
        if name.endswith((".cpp", ".h")) and (not name.endswith("Data.h") or name in COUNTED_DATA):
            text = open(os.path.join(PORT_DIR, name), encoding="utf-8", errors="replace").read()
            found.update(int(x) for x in re.findall(r"\b(\d{5,7})\b", text))
    return found


def load_script_bound(coa_core):
    """Spell ids that CoA's world updates bind (spell_script_names) to a script class this module registers."""
    ported = set()
    for name in ported_files():
        text = open(os.path.join(PORT_DIR, name), encoding="utf-8", errors="replace").read()
        ported.update(re.findall(r"Register(?:Spell|Aura)\w*\(\s*(\w+)", text))
    bound = set()
    root = os.path.join(coa_core, "data", "sql", "updates")
    for folder in ("db_world", "pending_db_world"):
        for name in sorted(os.listdir(os.path.join(root, folder))):
            if not name.endswith(".sql"):
                continue
            current = None
            for line in open(os.path.join(root, folder, name), encoding="utf-8", errors="replace"):
                m = re.match(r"\s*SET\s+@ScriptName\s*=\s*'(\w+)'", line, re.I)
                if m:
                    current = m.group(1)
                for sid, script in re.findall(r"\(\s*(-?\d+)\s*,\s*('\w+'|@ScriptName)\s*\)", line):
                    script = current if script == "@ScriptName" else script.strip("'")
                    if script in ported:
                        bound.add(abs(int(sid)))
    # Aetheria's Hero-only Rapid Strikes adapter is staged locally because the
    # pinned CoA core has no binding for this client-defined aura proc.
    bound.add(560341)
    return bound


def converted_aura(spell, row, sid, aura):
    """An aura past stock that a ported kit makes work (see CONVERTED_AURA_FAMILIES)."""
    if sid in CONVERTED_AURA_SPELLS.get(aura, ()):
        return True
    if aura in PROC_CARRIER_AURAS and spell.u(row, F_FAMILY) in KIT_FAMILIES and             (sid in ported_numbers() or sid in SCRIPT_BOUND):
        return True
    if spell.u(row, F_FAMILY) in NAMED_AURA_FAMILIES.get(aura, ()):
        return sid in ported_numbers() or sid in SCRIPT_BOUND
    if spell.u(row, F_FAMILY) not in CONVERTED_AURA_FAMILIES.get(aura, ()):
        return False
    return aura not in CONVERTED_AURA_NAMED_ONLY or sid in ported_numbers()


def blockers(spell, ids, scripted):
    found = set()
    for sid in ids:
        row = spell.index[sid]
        suppressed_aura_helper = (sid in SUPPRESSED_AURA_TRIGGER_HELPERS and
            SUPPRESSED_AURA_TRIGGER_HELPERS[sid] in ids and
            SUPPRESSED_AURA_TRIGGER_HELPERS[sid] in SCRIPT_BOUND)
        if sid in scripted and sid not in SCRIPT_REVIEWED:
            found.add("script")
        if sid in UNPORTED_ENGINE:
            found.add("engine:" + UNPORTED_ENGINE[sid])
        for i in range(3):
            effect, aura = spell.u(row, F_EFFECT + i), spell.u(row, F_AURA + i)
            if effect in (28, 56) and spell.u(row, F_MISC_VALUE + i) in (50047, 50070, 50146, 50329, 55066):
                found.add("summon:missing-template")
            if effect >= TARGET_EFFECTS and effect not in IMPLEMENTED_EFFECTS:
                found.add("effect:%d" % effect)
            if aura >= TARGET_AURAS and aura not in IMPLEMENTED_AURAS and \
                    not converted_aura(spell, row, sid, aura) and not suppressed_aura_helper:
                found.add("aura:%d" % aura)
            if aura in SPELL_MOD_AURAS:
                op = spell.u(row, F_MISC_VALUE + i)
                # Out-of-range ops must be ignored before SpellModifier construction. A script mention or
                # binding cannot protect that core path; only an exact pre-load data contract or core guard can.
                if op > MAX_SPELLMOD_OP and (sid, i, op) not in UPSTREAM_IGNORED_SPELLMOD_OPS and \
                        (sid, i, op) not in CONTRACTED_OUT_OF_RANGE_SPELLMODS and not SPELLMOD_RANGE_GUARD_AVAILABLE:
                    found.add("spellmod-op")
        # Focus costs belong to the Ranger (family 27), Runic Power costs to the Necromancer (29) and Reaper (36):
        # owning the kit makes the power type active (CoAGlueRanger.cpp, CoAGlueRunicPower.cpp)
        power, family = spell.u(row, F_POWER), spell.u(row, F_FAMILY)
        if power not in STOCK_POWERS and spell.u(row, F_COST) and not (power == 2 and family == 27) and not \
                (power == 6 and family in (29, 36)):
            found.add("power:%d" % power)
    return sorted(found)


def is_passive(spell, sid):
    return bool(spell.u(spell.index[sid], F_ATTR) & 0x40)


# spell_dbc's signed INT columns; every other INT column is UNSIGNED
SIGNED_COLUMNS = {0, 13, 15, 41, 224, 228} | set(range(52, 71)) | set(range(74, 77)) | set(range(80, 83)) \
    | set(range(110, 116))


def sql_value(col, raw):
    if col in FLOAT_COLUMNS:
        return repr(round(struct.unpack("<f", struct.pack("<I", raw))[0], 6))
    if col in SIGNED_COLUMNS:
        return str(struct.unpack("<i", struct.pack("<I", raw))[0])
    return str(raw)


def esc(text):
    return "'" + text.replace("\\", "\\\\").replace("'", "''").replace("\r", "\\r").replace("\n", "\\n") + "'"


TEXT_LIMITS = {"Name": 100, "NameSubtext": 100, "AuraDescription": 550}


def spell_row_sql(spell, sid, columns, stock_coefficient=()):
    row = spell.index[sid]
    vals = []
    for col in range(234):
        raw = spell.u(row, col)
        if col == F_EQUIP_INV and sid in CLEAR_EQUIP_SLOT:
            raw = 0
        if col in F_BONUS_MULTIPLIER and sid in stock_coefficient:
            raw = 0                        # CoA zeroes these at load (AscensionStockCoefficients.cpp)
        if col in (F_VISUAL, F_VISUAL + 1):
            raw = 0                        # drawn by the client only; build_coa_patch.py carries them
        if col in STRING_COLUMNS:
            # spell_dbc keeps names to 100 characters and aura text to 550, where the client table holds more
            limit = TEXT_LIMITS.get(columns[col].rsplit("_Lang_", 1)[0], 0)
            if raw and (raw >= len(spell.strings) or spell.strings.find(b"\0", raw) < 0):
                if col in (136, 153, 170, 187):
                    raise ValueError("spell %d has an invalid enUS string offset in Spell.dbc field %d" % (sid, col))
                raw = 0  # blank malformed non-enUS locale offsets; keep server/client copies valid
            text = spell.s(row, col) if raw else ""
            vals.append(esc(text[:limit] if limit else text) if raw else "''")
        else:
            vals.append(sql_value(col, raw))
    return "(" + ", ".join(vals) + ")"


def spell_columns():
    text = open(os.path.join(MODULE, "data", "sql", "db-world", "cw_spells_forged.sql"), encoding="utf-8").read()
    cols = re.search(r"INSERT INTO `spell_dbc` \(([^)]*)\)", text).group(1)
    names = [c.strip(" `\n") for c in cols.split(",")]
    assert len(names) == 234, len(names)
    return names


def legacy_race_mask(race_id):
    race = RACE_MASK_ALIAS.get(race_id, race_id)
    if not 1 <= race <= 32:
        raise SystemExit("race %d has no legacy RaceMask representation" % race_id)
    return 1 << (race - 1)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--coa-client", required=True)
    ap.add_argument("--coa-core", required=True)
    ap.add_argument("--target-client", required=True)
    ap.add_argument("--server-spell-dbc", required=True)
    ap.add_argument("--world-spell-ids", required=True,
                    help="one spell_dbc ID per line from the target world database")
    ap.add_argument("--coverage", required=True, help="where to write the coverage manifest")
    ap.add_argument("--coverage-only", action="store_true",
                    help="write the coverage manifest without updating SQL, generated headers, or client manifest")
    args = ap.parse_args()

    source = coa.target_archives(args.coa_client)
    target = coa.target_archives(args.target_client)
    target_races = set(Dbc(read_table(target, "ChrRaces")).index)
    server_race_path = os.path.join(os.path.dirname(os.path.abspath(args.server_spell_dbc)), "ChrRaces.dbc")
    if not os.path.isfile(server_race_path):
        raise SystemExit("server ChrRaces.dbc is required beside --server-spell-dbc: " + server_race_path)
    server_races = set(Dbc(open(server_race_path, "rb").read()).index)
    # The staged client can contain race rows that are not yet supported by the
    # paired server DBC. Never generate server spell/access data for those rows;
    # require every server race to exist client-side and select only their
    # intersection for the paired Hero racial catalog.
    client_only_races = sorted(target_races - server_races)
    missing_client_races = sorted(server_races - target_races)
    if missing_client_races:
        raise SystemExit("server ChrRaces.dbc has race IDs absent from the target client: "
                         + ", ".join(map(str, missing_client_races)))
    paired_races = target_races & server_races
    racial_races = sorted(set(coa_racials.RACIALS) & paired_races)
    if not racial_races:
        raise SystemExit("no CoA custom racial definitions match the paired target ChrRaces.dbc")

    tables = {t: Dbc(read_table(source, t))
              for t in ("ChrClasses", "CharacterAdvancementClassTypes", "CharacterAdvancementTabTypes",
                        "ChrSpecs", "CharacterAdvancement")}
    # clone rows for the CoA spells whose id Esteria already uses or that two entries both offer (lib/coa.py)
    icon_data = read_table(source, "SpellIcon")
    spell_data = coa.apply_clones(read_table(source, "Spell"))
    spell_data, racial_rows = coa.append_custom_racial_spells(spell_data, icon_data, racial_races)
    spell = Dbc(spell_data)
    affect = Dbc(read_table(source, "SpellAffect"))
    SPELL_AFFECT_MODIFIERS.update(affect.u(r, 1) for r in range(affect.n))
    # Only these exact Cultist event/driver records and Guardian records are dummied by their contracts.
    cultist_data = open(os.path.join(PORT_DIR, "AscensionCultistData.h"), encoding="utf-8").read()
    cultist_proc = set()
    for name in ("CultistEvents", "CultistDrivers"):
        body = re.search(name + r"\[\]\s*=\s*\{([^}]+)\}", cultist_data).group(1)
        cultist_proc.update(int(value) for value in re.findall(r"\d+", body))
    for aura in (353, 354):
        CONVERTED_AURA_SPELLS.setdefault(aura, set()).update(cultist_proc)
    SCRIPT_BOUND.update(load_script_bound(args.coa_core))
    CONVERTED_AURA_SPELLS[354].update({706807, 705379, 524694, 804891, 801778})
    icons = Dbc(icon_data)
    entries, class_names, specs = join_entries(tables)
    for e in entries:
        # the Witch Doctor talent and ability line offered the same two spells: the talent takes the clones
        if e["id"] in ENTRY_RANK_CLONES:
            e["ranks"] = [ENTRY_RANK_CLONES[e["id"]].get(r, r) for r in e["ranks"]]
    assert len(class_names) == 21, len(class_names)
    assert len(specs) == 70, len(specs)
    assert len(entries) == 3616, len(entries)

    budgets = load_budgets(Dbc(read_table(source, "CharacterAdvancementEssence")))
    chains = load_progression(args.coa_core)
    scripted, stock_coefficient, scaled = load_scripted(args.coa_core)

    tgt_client = set(Dbc(read_table(target, "Spell")).index)
    tgt_server = set(Dbc(open(args.server_spell_dbc, "rb").read()).index)
    tgt_world = {int(x) for x in open(args.world_spell_ids).read().split() if x.strip()}
    racial_spell_set = {spell_id for race_id in racial_races for spell_id in coa_racials.spell_ids(race_id)}
    racial_collisions = sorted(racial_spell_set & (tgt_client | tgt_server | tgt_world))
    if racial_collisions:
        raise SystemExit("CoA racial spell IDs already exist in a target catalog: "
                         + ", ".join(str(spell_id) for spell_id in racial_collisions[:20]))

    target_sla = Dbc(read_table(target, "SkillLineAbility"))
    server_root = os.path.normpath(os.path.join(MODULE, "../../../../.."))
    repo_root = os.path.dirname(server_root)
    server_sla_path = os.path.join(repo_root, "isolated-test", "runtime", "Data", "dbc", "SkillLineAbility.dbc")
    if not os.path.isfile(server_sla_path):
        raise SystemExit("paired server SkillLineAbility.dbc is missing: " + server_sla_path)
    server_sla = Dbc(open(server_sla_path, "rb").read())
    racial_sla_id_collisions = sorted(racial_spell_set & (set(target_sla.index) | set(server_sla.index)))
    if racial_sla_id_collisions:
        raise SystemExit("CoA racial SkillLineAbility row IDs collide with a target table: "
                         + ", ".join(str(row_id) for row_id in racial_sla_id_collisions[:20]))
    racial_skillline_rows = []
    for spell_id, race_id, _template, _icon in racial_rows:
        mask = legacy_race_mask(race_id)
        racial_skillline_rows.append((spell_id, HERO_SKILL_LINE, spell_id, mask, HERO_CLASS_MASK,
                                      0, 0, 0, 0, 0, 0, 0, 0, 0))

    coverage = []
    pilot = []
    for e in entries:
        ids = closure(spell, e["ranks"], chains)
        occupied = sorted(set(ids) & (tgt_client | tgt_server | tgt_world))
        found = blockers(spell, ids, scripted)
        if e["id"] in HELD_KIT_ENTRIES:
            found = sorted(set(found) | {"kit:unported"})
        # an entry that costs nothing and sits in a group is one of a free choice (pick one, the others go);
        # one that costs nothing and is in no group is granted automatically
        e["free"] = bool(not e["ae"] and not e["te"] and e["group"])
        if not e["ae"] and not e["te"] and not e["group"]:
            disposition = "support"
        elif occupied:
            disposition = "id-collision"
        elif found:
            disposition = "blocked"
        else:
            disposition = "candidate"
        if e["id"] in PILOT_ENTRIES and disposition != "candidate":
            raise SystemExit("pilot entry %d is %s: %s %s" % (e["id"], disposition, found, occupied))
        if disposition == "candidate":
            disposition = "enabled"
        if disposition == "enabled":
            e["req_level"] = investment_level(budgets, e)
            pilot.append((e, ids))
        named_in = sorted({f for sid in ids if sid not in SCRIPT_REVIEWED for f in scripted.get(sid, [])})
        coverage.append(dict(e, spells=ids, blockers=found, occupied=occupied, disposition=disposition,
                             named_in=named_in,
                             progression=[list(r) for r in chains.get(e["ranks"][0], [])] if e["ranks"] else []))

    # CoA entries need up to three others, all of them owned. A required entry that is itself offered counts, and
    # so does an automatic one (a specialisation's signature ability), which the module grants once the Hero owns
    # something of that specialisation; a required entry that is blocked or held takes its dependants with it.
    disp = {c["id"]: c["disposition"] for c in coverage}
    # an automatic entry is only a usable prerequisite when nothing blocks its own spells
    unblocked_support = {c["id"] for c in coverage if c["disposition"] == "support" and not c["blockers"]}
    changed = True
    while changed:
        changed = False
        for c in coverage:
            if c["disposition"] == "enabled" and c["requires"] and                     not all(disp.get(r) == "enabled" or r in unblocked_support for r in c["requires"]):
                c["disposition"] = disp[c["id"]] = "needs-prerequisite"
                changed = True
    held = {i for i, d in disp.items() if d == "needs-prerequisite"}
    pilot = [(e, ids) for e, ids in pilot if e["id"] not in held]
    # Automatic entries (cost nothing, in no choice group): CoA grants them with the class and specialisation
    # once the level and the entries they require are there. A Hero gets them with the specialisation the same way
    # (cw_coa_automatic), and the entries that require one (a specialisation's signature ability) find it granted.
    automatic_entries = {c["id"] for c in coverage if c["id"] in unblocked_support and
                         all(r in unblocked_support or disp.get(r) == "enabled" for r in c["requires"])}

    # Two entries whose own rank spells overlap (a talent whose rank 1 is also an
    # ability) cannot both be owned apart: one would hand out or take away the
    # other's spell. Both wait for a decision. Shared helper spells are fine.
    root_owner = {}
    for e, _ids in pilot:
        for sid in e["ranks"]:
            root_owner.setdefault(sid, []).append(e["id"])
    shared = {i for owners in root_owner.values() if len(owners) > 1 for i in owners}
    pilot = [(e, ids) for e, ids in pilot if e["id"] not in shared]
    for c in coverage:
        if c["id"] in shared:
            c["disposition"] = "shared-root"

    # Spells nothing in the data reaches: what the ported code casts by id, and
    # what an owned spell teaches. They ride along as support, never picked.
    enabled_spells = {sid for _e, ids in pilot for sid in ids}
    extra = set()
    # (entry, class, spec, spell, level, requires, baseline, team): an automatic entry's ranks
    signatures = []
    for e in entries:
        if e["id"] in automatic_entries and e["ranks"]:
            first = e["ranks"][0]
            level = max(e["level"], spell.u(spell.index[first], 39), 1)
            for sid, lvl in [(first, level)] + [(s, l) for s, l in chains.get(first, [])]:
                signatures.append((e["id"], e["cls"], e["spec"], sid, max(lvl, 1),
                                   " ".join(str(r) for r in e["requires"]), 0, TEAM_ANY))
                extra.update(closure(spell, [sid], {}))
    for sid in script_helpers(spell) | script_bound_spells(spell, args.coa_core):
        extra.update(closure(spell, [sid], {}))
    for sid in EXPLICIT_SUPPORT_SPELLS:
        if sid not in spell.index:
            raise SystemExit("required CoA support spell %d is missing from the winning source Spell.dbc" % sid)
        extra.update(closure(spell, [sid], chains))
    taught = [(p, c) for p, c in load_taught(args.coa_core) if p in enabled_spells and c in spell.index]
    for _p, c in taught:
        extra.update(closure(spell, [c], chains))
    taken = tgt_client | tgt_server | tgt_world
    # CoA's class baseline (AscensionCustomClassData.h ClassSpells) and the Felsworn capital rifts, granted with
    # the class (spec 0) like the automatic entries above. Left out: ids Esteria already has (stock Dodge, Block,
    # ...: Esteria's own), spells a sold entry or a taught spell owns (the sync would take away a bought spell).
    taught_children = {c for _p, c in load_taught(args.coa_core)}
    baseline_count = 0
    for i, (cls, level, sid, baseline, team) in enumerate(class_baseline(args.coa_core)):
        ranks = [(sid, level)] + [(s, max(l, level)) for s, l in chains.get(sid, [])]
        # also left out: a row with broken strings, or an effect/aura past this core's range (SpellMgr asserts)
        if any(s not in spell.index or s in taken or s in enabled_spells or s in taught_children or
               not well_formed(spell, s) or any(b.startswith(("effect:", "aura:")) for b in blockers(spell, [s], {}))
               for s, _l in ranks):
            continue
        for s, lvl in ranks:
            signatures.append((BASELINE_ENTRY + i, cls, 0, s, max(lvl, 1), "", baseline, team))
            extra.update(t for t in closure(spell, [s], {}) if well_formed(spell, t))
        baseline_count += 1
    print("class baseline: %d of the ClassSpells rows and rifts granted with their class" % baseline_count)
    extra.update(racial_spell_set)
    clash = sorted(s for s in extra - enabled_spells if s in taken)
    for s_ in clash:
        print("  clash %d: %s" % (s_, spell.s(spell.index[s_], F_NAME)))
    extra -= enabled_spells | taken
    # An effect or aura past this core's range is not just unhandled: SpellMgr
    # asserts on it at load and the worldserver does not start.
    beyond = {s for s in extra
              if any(b.startswith(("effect:", "aura:")) for b in blockers(spell, [s], {}))}
    bad_racials = sorted(racial_spell_set & beyond)
    if bad_racials:
        raise SystemExit("CoA racial template spells require unsupported effects/auras: "
                         + ", ".join(str(spell_id) for spell_id in bad_racials))
    extra -= beyond
    if beyond:
        print("support spells left out for effects/auras this core lacks: %d" % len(beyond))
        for s_ in sorted(beyond):
            print("  left out %d: %s" % (s_, ",".join(blockers(spell, [s_], {}))))
    print("support spells: %d from ported code and taught abilities, %d left out (id in use here)"
          % (len(extra), len(clash)))

    counts = {}
    for c in coverage:
        counts[c["disposition"]] = counts.get(c["disposition"], 0) + 1
    with open(args.coverage, "w", encoding="utf-8") as out:
        json.dump(dict(classes=class_names, specs=specs, counts=counts, entries=coverage,
                       coa_racial_races=racial_races, coa_racial_spell_rows=len(racial_spell_set),
                       coa_unpaired_client_races=client_only_races,
                       coa_racial_skillline_rows=len(racial_skillline_rows)), out, indent=1)
    print("coverage:", counts)

    if args.coverage_only:
        return

    class_specs = {}
    for e in entries:
        if e["spec"]:
            class_specs.setdefault(e["cls"], set()).add(e["spec"])
    write_outputs(spell, icons, pilot, class_names, specs, {c: sorted(s) for c, s in class_specs.items()}, chains,
                  stock_coefficient, scaled, extra, taught, source, affect, args.coa_core, signatures,
                  racial_races, racial_rows, racial_skillline_rows)


def kind_of(spell, e, chains):
    """0 ability line, 1 talent. A line that ranks up with level, or anything
    castable, is an ability; a passive ranked per point is a talent."""
    first = e["ranks"][0]
    if e["type"] == "Ability" or chains.get(first) or not is_passive(spell, first):
        return 0
    return 1


def write_outputs(spell, icons, pilot, class_names, specs, class_specs, chains, stock_coefficient, scaled,
                  extra, taught, source, affect, core, signatures=(), racial_races=(), racial_rows=(),
                  racial_skillline_rows=()):
    columns = spell_columns()
    tabs = {}           # synthetic tab id -> (class, spec)
    rows, ranks, talents, catalog, icon_ids, emitted = [], [], [], [], set(), set()
    for e, ids in pilot:
        cls, kind = e["cls"], kind_of(spell, e, chains)
        # slot 0 is the class-wide tree, 1-4 the specs in id order
        slot = 0 if not e["spec"] else 1 + class_specs[cls].index(e["spec"])
        tab_id = TAB_ID_BASE + cls * 10 + slot
        first = e["ranks"][0]
        # talents open with talent essence at 10; a line at its rank 1 spell level
        req_level = max(e["req_level"], 10 if kind else spell.u(spell.index[first], 39), 1)
        if kind:
            tabs[tab_id] = (cls, e["spec"])
        for sid in ids:
            if sid in emitted:
                continue                   # a helper another entry also triggers
            emitted.add(sid)
            rows.append(spell_row_sql(spell, sid, columns, stock_coefficient))
            row = spell.index[sid]
            icon_ids.update(i for i in (spell.u(row, F_ICON), spell.u(row, F_ACTIVE_ICON)) if i)
        talent_id = 0
        if kind == 0:
            chain = [(first, req_level)] + chains.get(first, [])
            for n, (sid, _lvl) in enumerate(chain, 1):
                ranks.append("(%d, %d, %d)" % (first, sid, n))
        else:
            talent_id = TALENT_ID_BASE + e["id"]
            rank_spells = (e["ranks"] + [0] * 9)[:9]
            row_tier = max(0, (req_level - 10) // 5)
            # prerequisites stay in cw_coa_entries: the native row holds one, CoA up to three
            talents.append("(%d, %d, %d, 0, %s, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)"
                           % (talent_id, tab_id, row_tier, ", ".join(str(s) for s in rank_spells)))
        catalog.append("(%d, %d, %d, %d, %d, %d, %d, %d, '%s', 0, 1, %d, %d)" % (
            e["id"], cls, e["spec"], tab_id, kind, first if kind == 0 else 0, talent_id, req_level,
            " ".join(str(r) for r in e["requires"]), e["group"] if e.get("free") else 0, 1 if e.get("free") else 0))

    for sid in sorted(extra):
        if sid not in emitted:
            emitted.add(sid)
            rows.append(spell_row_sql(spell, sid, columns, stock_coefficient))
            row = spell.index[sid]
            icon_ids.update(i for i in (spell.u(row, F_ICON), spell.u(row, F_ACTIVE_ICON)) if i)

    spell_ids = sorted({sid for _e, ids in pilot for sid in ids} | extra)
    out = os.path.join(MODULE, "data", "sql", "generated", "cw_spells_coa.sql")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write(SQL_HEAD)
        f.write("DELETE FROM `cw_coa_classes`;\n")
        f.write("INSERT INTO `cw_coa_classes` (`class`, `name`, `icon_spell`) VALUES\n")
        used = sorted({e["cls"] for e, _ids in pilot})
        f.write(",\n".join("(%d, %s, %d)" % (c, esc(class_names[c]), next(
            e["ranks"][0] for e, _ids in pilot if e["cls"] == c)) for c in used) + ";\n\n")
        f.write("DELETE FROM `cw_coa_tabs`;\n")
        f.write("INSERT INTO `cw_coa_tabs` (`tab_id`, `class`, `spec`, `name`) VALUES\n")
        f.write(",\n".join("(%d, %d, %d, %s)" % (t, c, s, esc(specs[s]["name"] if s else class_names[c]))
                           for t, (c, s) in sorted(tabs.items())) + ";\n\n")
        f.write("DELETE FROM `cw_coa_entries`;\n")
        f.write("INSERT INTO `cw_coa_entries` (`entry`, `class`, `spec`, `tab_id`, `kind`, `first_spell`, "
                "`talent_id`, `req_level`, `requires`, `in_pool`, `enabled`, `choice_group`, `free`) VALUES\n")
        f.write(",\n".join(catalog) + ";\n\n")
        id_list = ", ".join(str(s) for s in spell_ids)
        f.write("DELETE FROM `spell_dbc` WHERE `ID` IN (%s);\n" % id_list)
        f.write("INSERT INTO `spell_dbc` (%s) VALUES\n" % ", ".join("`%s`" % c for c in columns))
        f.write(",\n".join(rows) + ";\n\n")
        if racial_skillline_rows:
            racial_spell_list = sorted(row[2] for row in racial_skillline_rows)
            f.write("DELETE FROM `skilllineability_dbc` WHERE `Spell` IN (%s);\n"
                    % ", ".join(str(spell_id) for spell_id in racial_spell_list))
            f.write("INSERT INTO `skilllineability_dbc` (`ID`, `SkillLine`, `Spell`, `RaceMask`, `ClassMask`, "
                    "`ExcludeRace`, `ExcludeClass`, `MinSkillLineRank`, `SupercededBySpell`, `AcquireMethod`, "
                    "`TrivialSkillLineRankHigh`, `TrivialSkillLineRankLow`, `CharacterPoints_1`, "
                    "`CharacterPoints_2`) VALUES\n")
            # the `_dbc` table columns are signed 32-bit; race bit 31 must be written as its signed value
            def signed32(value):
                return value - (1 << 32) if isinstance(value, int) and value >= (1 << 31) else value
            f.write(",\n".join("(" + ", ".join(str(signed32(value)) for value in row) + ")"
                                 for row in racial_skillline_rows) + ";\n\n")
            f.write("DELETE FROM `cw_classless_racial_abilities` WHERE `spell_id` IN (%s);\n"
                    % ", ".join(str(spell_id) for spell_id in racial_spell_list))
            f.write("INSERT INTO `cw_classless_racial_abilities` (`spell_id`, `race_id`) VALUES\n")
            f.write(",\n".join("(%d, %d)" % (spell_id, race_id)
                                 for spell_id, race_id, _template, _icon in racial_rows) + ";\n\n")
        if ranks:
            firsts = ", ".join(sorted({r.split(",")[0][1:] for r in ranks}))
            f.write("DELETE FROM `spell_ranks` WHERE `first_spell_id` IN (%s);\n" % firsts)
            f.write("INSERT INTO `spell_ranks` (`first_spell_id`, `spell_id`, `rank`) VALUES\n")
            f.write(",\n".join(ranks) + ";\n\n")
        f.write("DELETE FROM `talenttab_dbc` WHERE `ID` BETWEEN %d AND %d;\n" % (TAB_ID_BASE, TAB_ID_BASE + 330))
        f.write("INSERT INTO `talenttab_dbc` (`ID`, `Name_Lang_enUS`, `Name_Lang_Mask`, `SpellIconID`, `RaceMask`, "
                "`ClassMask`, `PetTalentMask`, `OrderIndex`, `BackgroundFile`) VALUES\n")
        f.write(",\n".join("(%d, %s, 16712190, 0, 0, %d, 0, %d, '')" % (
            t, esc(specs[s]["name"] if s else class_names[c]), HIDDEN_TAB_CLASS_MASK, t % 10)
            for t, (c, s) in sorted(tabs.items())) + ";\n\n")
        f.write("DELETE FROM `talent_dbc` WHERE `ID` BETWEEN %d AND %d;\n" % (TALENT_ID_BASE, TALENT_ID_BASE + 99999))
        if talents:
            f.write("INSERT INTO `talent_dbc` (`ID`, `TabID`, `TierID`, `ColumnIndex`, `SpellRank_1`, "
                    "`SpellRank_2`, `SpellRank_3`, `SpellRank_4`, `SpellRank_5`, `SpellRank_6`, `SpellRank_7`, "
                    "`SpellRank_8`, `SpellRank_9`, `PrereqTalent_1`, `PrereqTalent_2`, `PrereqTalent_3`, "
                    "`PrereqRank_1`, `PrereqRank_2`, `PrereqRank_3`, `Flags`, `RequiredSpellID`, "
                    "`CategoryMask_1`, `CategoryMask_2`) VALUES\n")
            f.write(",\n".join(talents) + ";\n")
        f.write("\nDELETE FROM `cw_coa_taught`;\n")
        if taught:
            f.write("INSERT INTO `cw_coa_taught` (`parent`, `spell`) VALUES\n")
            f.write(",\n".join("(%d, %d)" % row for row in sorted(set(taught))) + ";\n")
        f.write("\nDELETE FROM `cw_coa_automatic`;\n")
        if signatures:
            f.write("INSERT INTO `cw_coa_automatic` (`entry`, `class`, `spec`, `spell`, `req_level`, `requires`, "
                    "`baseline`, `team`) VALUES\n")
            f.write(",\n".join("(%d, %d, %d, %d, %d, '%s', %d, %d)" % row for row in sorted(set(signatures))) + ";\n")
        scaling = [(sid, scaled[sid]) for sid in spell_ids if sid in scaled]
        f.write("\nDELETE FROM `cw_coa_spell_scaling`;\n")
        if scaling:
            f.write("INSERT INTO `cw_coa_spell_scaling` (`spell`, `effect_mask`) VALUES\n")
            f.write(",\n".join("(%d, %d)" % row for row in scaling) + ";\n")
    print("wrote", out, len(spell_ids), "spell rows,", len(scaling), "level-scaled")

    sys.path.insert(0, os.path.join(MODULE, "tools"))
    from coa_spell_affect import imported_targets, client_targets, write_header as write_affect_header
    from coa_spell_charges import charge_rows, write_header as write_charge_header
    affect_rows = imported_targets(affect.data, spell.data, set(spell_ids))
    write_affect_header(os.path.join(PORT_DIR, "CoASpellAffectData.h"), affect_rows)
    progression = open(os.path.join(core, "src", "server", "coa",
                                   "AscensionSpellProgressionData.h"), encoding="utf-8").read()
    charges = charge_rows(read_table(source, "SpellCharges"), read_table(source, "SpellChargesCategory"),
                          set(spell_ids), progression)
    write_charge_header(os.path.join(PORT_DIR, "CoASpellChargesData.h"), charges)
    # Spells whose tooltip shows a live aura amount ($w1..$w3, CoA's client extension): the server sends their
    # amounts (SMSG_ESTERIA_AURA_AMOUNT) and nothing else's.
    amount_spells = sorted(sid for sid in spell_ids if re.search(
        r"\$[wW][1-3]", spell.s(spell.index[sid], 170) + spell.s(spell.index[sid], 187)))
    with open(os.path.join(PORT_DIR, "CoAAuraAmountSpells.h"), "w", encoding="utf-8", newline="\n") as h:
        h.write("// Generated by gen_coa_import.py; do not edit.\n#ifndef CW_COA_AURA_AMOUNT_SPELLS_H\n"
                "#define CW_COA_AURA_AMOUNT_SPELLS_H\n\n#include <array>\n#include <cstdint>\n\n"
                "// sorted: imported spells whose tooltip names a live aura amount ($w1..$w3)\n"
                "inline constexpr std::array<uint32_t, %d> CoAAuraAmountSpells = {{\n" % len(amount_spells))
        h.write("".join("    %d,\n" % sid for sid in amount_spells) + "}};\n\n#endif\n")
    print("aura amount spells:", len(amount_spells))

    creatures = {spell.u(spell.index[sid], 110 + i) for sid in spell_ids for i in range(3)
                 if spell.u(spell.index[sid], 71 + i) in (28, 56)} - {0}
    objects = {spell.u(spell.index[sid], 110 + i) for sid in spell_ids for i in range(3)
               if spell.u(spell.index[sid], 71 + i) in (50, 76, 104, 105, 106, 107)} - {0}
    manifest = dict(version=1, client_power_overrides={802629: 3}, spell_affect=client_targets(affect_rows, chains), charges=charges, summoned_creatures=sorted(creatures),
                    summoned_objects=sorted(objects), spells=spell_ids, clear_equip_slot=sorted(set(spell_ids) & CLEAR_EQUIP_SLOT),
                    coa_racial_races=sorted(racial_races),
                    racial_skillline_abilities=[list(row) for row in racial_skillline_rows],
                    icons=sorted(icon_ids), icon_paths={i: icons.s(icons.index[i], 1) for i in sorted(icon_ids)
                                                        if i in icons.index})
    with open(os.path.join(MODULE, "client-patch", "coa_manifest.json"), "w", encoding="utf-8", newline="\n") as f:
        json.dump(manifest, f, indent=1)
        f.write("\n")


SQL_HEAD = """-- mod-classless-wildcard: Conquest of Azeroth class kits, generated by
-- data/sql/generators/gen_coa_import.py. Do not hand-edit.
-- Requires a worldserver restart.

CREATE TABLE IF NOT EXISTS `cw_coa_classes` (
  `class` TINYINT UNSIGNED NOT NULL COMMENT 'CoA class id, 12-32',
  `name` VARCHAR(32) NOT NULL,
  `icon_spell` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'spell whose icon the browser shows',
  PRIMARY KEY (`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog classes';

CREATE TABLE IF NOT EXISTS `cw_coa_tabs` (
  `tab_id` INT UNSIGNED NOT NULL COMMENT 'talenttab_dbc id',
  `class` TINYINT UNSIGNED NOT NULL,
  `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'CoA ChrSpecs id, 0 = class-wide',
  `name` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`tab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog trees';

DROP TABLE IF EXISTS `cw_coa_entries`;
CREATE TABLE `cw_coa_entries` (
  `entry` INT UNSIGNED NOT NULL COMMENT 'CoA CharacterAdvancement id',
  `class` TINYINT UNSIGNED NOT NULL,
  `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  `tab_id` INT UNSIGNED NOT NULL,
  `kind` TINYINT UNSIGNED NOT NULL COMMENT '0 ability line, 1 talent',
  `first_spell` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'ability: rank 1',
  `talent_id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'talent: talent_dbc id',
  `req_level` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `requires` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'CoA entry ids, space separated',
  `in_pool` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Wildcard can roll it',
  `enabled` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `choice_group` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'CoA choice group: owning one removes the others',
  `free` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'a free choice: costs no essence',
  PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA catalog entries';

DROP TABLE IF EXISTS `cw_coa_signatures`;
DROP TABLE IF EXISTS `cw_coa_automatic`;
CREATE TABLE `cw_coa_automatic` (
  `entry` INT UNSIGNED NOT NULL COMMENT 'CoA CharacterAdvancement id of the automatic entry',
  `class` TINYINT UNSIGNED NOT NULL,
  `spec` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = granted with the class',
  `spell` INT UNSIGNED NOT NULL COMMENT 'a rank of it',
  `req_level` TINYINT UNSIGNED NOT NULL DEFAULT 1,
  `requires` VARCHAR(64) NOT NULL DEFAULT '' COMMENT 'CoA entry ids that must be held, space separated',
  `baseline` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '1 = CoA ClassSpells baseline (ClasslessWildcard.CoA.ClassSpells)',
  `team` TINYINT UNSIGNED NOT NULL DEFAULT 2 COMMENT 'TeamId that gets it: 0 Alliance, 1 Horde, 2 any',
  PRIMARY KEY (`entry`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA automatic entries, granted with their specialisation';

CREATE TABLE IF NOT EXISTS `cw_coa_taught` (
  `parent` INT UNSIGNED NOT NULL COMMENT 'learning this spell',
  `spell` INT UNSIGNED NOT NULL COMMENT 'also teaches this one, and forgetting it takes it away',
  PRIMARY KEY (`parent`, `spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA taught abilities';

CREATE TABLE IF NOT EXISTS `cw_coa_spell_scaling` (
  `spell` INT UNSIGNED NOT NULL,
  `effect_mask` TINYINT UNSIGNED NOT NULL COMMENT 'effects whose base points follow the level curve',
  PRIMARY KEY (`spell`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Classless CoA level-scaled spells';

"""


if __name__ == "__main__":
    main()
