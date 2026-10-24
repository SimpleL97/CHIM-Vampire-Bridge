"""CHIM Vampire Bridge - writes the game plugin build/CHIMVampireBridge.esp.

The plugin is tiny and has no art or world edits, so it is generated here byte by
byte instead of being saved from the Creation Kit or xEdit. Running this again gives
the same file. It holds:

  TES4 header   ESL flag (0x200), author SaurOff, master Skyrim.esm, form version 44
  0x800 QUST    COV_BridgeQuest  - script COV_Bridge  (the AI's vampire actions)
  0x801 QUST    COV_EventsQuest  - script COV_Events  (state and settings to CHIM)
  0x802 QUST    COV_MCMQuest     - script COV_MCM     (MCM Helper menu) and a player
                                   alias with SkyUI's SKI_PlayerLoadGameAlias, which
                                   MCM Helper needs to re-register the menu on load
  0x803 MGEF    COV_ThrallEffect - script COV_EnthrallEffect (the bite)
  0x804 SPEL    COV_ThrallPower  - lesser power "Vampire's Thrall" (shout key): raises the
                                   dead as the player's thralls
  0x805 PERK    COV_SleepThrallPerk - script fragment PRKF_COV_SleepThrallPerk: the choice
                                   "Make your thrall" next to Feed on a sleeping person,
                                   for a Vampire Lord player
  0x806 FACT    COV_ThrallFaction - every thrall of this mod (no relations, hidden)

The three quests are start-game-enabled (DNAM flags 0x0111), so they also start
on an existing save. Run: python3 -I make_esp.py [output path]
"""
import os, struct, sys

ROOT = os.path.dirname(os.path.abspath(__file__))
out = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, "build", "CHIMVampireBridge.esp")


def sub(tag, data):
    return tag + struct.pack('<H', len(data)) + data


def wstr(s):
    b = s.encode()
    return struct.pack('<H', len(b)) + b


def zstr(s):
    return s.encode() + b'\0'


def script(name):
    return wstr(name) + b'\x00' + struct.pack('<H', 0)  # status 0, no properties


def vmad_plain(name):
    return struct.pack('<hhH', 5, 2, 1) + script(name)  # VMAD version 5, object format 2, one script


def vmad_mcm(name, quest_fid):
    v = struct.pack('<hhH', 5, 2, 1) + script(name)
    v += b'\x02' + struct.pack('<H', 0) + struct.pack('<H', 0)  # quest fragments: version 2, none, no file
    v += struct.pack('<H', 1)                                   # one alias script block
    v += struct.pack('<HhI', 0, 0, quest_fid)                   # alias 0 of this quest
    v += struct.pack('<hhH', 5, 2, 1) + script('SKI_PlayerLoadGameAlias')
    return v


# start game enabled, run once off, priority 0xFF
DNAM = bytes.fromhex('110100ff0000000000000000')


def quest(fid, edid, full, vmad, alias=False):
    d = sub(b'EDID', zstr(edid)) + sub(b'VMAD', vmad) + sub(b'FULL', zstr(full)) + sub(b'DNAM', DNAM) + sub(b'NEXT', b'')
    if alias:
        d += sub(b'ANAM', struct.pack('<I', 1))
        d += sub(b'ALST', struct.pack('<I', 0)) + sub(b'ALID', zstr('PlayerAlias'))
        d += sub(b'FNAM', struct.pack('<I', 0)) + sub(b'ALFR', struct.pack('<I', 0x14))  # forced ref: the player (0x14)
        d += sub(b'VTCK', struct.pack('<I', 0)) + sub(b'ALED', b'')
    else:
        d += sub(b'ANAM', struct.pack('<I', 0))
    return b'QUST' + struct.pack('<IIIIHH', len(d), 0, fid, 0, 44, 0) + d


def group(tag, content):
    return b'GRUP' + struct.pack('<I', 24 + len(content)) + tag + struct.pack('<IHHHH', 0, 0, 0, 0, 0) + content


def record(tag, fid, body):
    return tag + struct.pack('<IIIIHH', len(body), 0, fid, 0, 44, 0) + body


# "Vampire's Thrall": a lesser power (shout key) laid out like the vanilla PowerKhajiitNightEye
# (SPEL 0AA01D) and its scripted self effect; the script COV_EnthrallEffect bites the
# person under the crosshair. MGEF DATA, 152 bytes: flags NoDuration|NoMagnitude|NoArea|
# HideInUI|Painless, no magic school, archetype Script (1), fire and forget, self.
MGEF_DATA = struct.pack('<IfIiiHHIfIIIIffffIiIIIIiIIIfIfIIIIIIIff',
                        0x04008E00, 0.0, 0, -1, -1, 0, 0, 0, 0.0, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0.0,
                        1, -1, 0, 0, 1, 0, -1, 0, 0, 0, 0.0, 0, 1.0, 0, 0, 0, 0, 0, 0, 0, 0.0, 0.0)
assert len(MGEF_DATA) == 152
THRALL_DESC = ("Raise the dead body you are looking at: they rise whole and alive as your thrall, and obey you "
               "and your companions in everything. It does nothing to the living.")
mgef = record(b'MGEF', 0x01000803,
              sub(b'EDID', zstr('COV_ThrallEffect')) + sub(b'VMAD', vmad_plain('COV_EnthrallEffect'))
              + sub(b'FULL', zstr("Vampire's Thrall")) + sub(b'DATA', MGEF_DATA) + sub(b'DNAM', zstr(THRALL_DESC)))
spel = record(b'SPEL', 0x01000804,
              sub(b'EDID', zstr('COV_ThrallPower')) + sub(b'OBND', bytes(12)) + sub(b'FULL', zstr("Vampire's Thrall"))
              + sub(b'MDOB', struct.pack('<I', 0x0435A5)) + sub(b'ETYP', struct.pack('<I', 0x025BEE))  # equip: voice (shout key)
              + sub(b'DESC', zstr(THRALL_DESC))
              + sub(b'SPIT', struct.pack('<IIIfIIfff', 0, 0, 3, 0.0, 1, 0, 0.0, 0.0, 0.0))  # lesser power, fire and forget, self
              + sub(b'EFID', struct.pack('<I', 0x01000803)) + sub(b'EFIT', struct.pack('<fII', 0.0, 0, 1)))

def ctda(op_flags, value, func, param1=0, run_on=0):
    """one condition: CTDA, 32 bytes (operator/flags, comparison value, function, parameter, run on)"""
    return sub(b'CTDA', struct.pack('<B3sfHHIIIIi', op_flags, b'\0\0\0', value, func, 0, param1, 0, run_on, 0, -1))


# Conditions copied from VampireFeed's sleeping-target entry: the owner (player) is not swimming
# (IsSwimming 185 == 0); the target is alive (GetDead 46 == 0), no child (IsChild 365 == 0), a
# person (HasKeyword 560 ActorTypeNPC 013794 == 1), asleep (GetSleeping 49 == 3) and no thrall yet
# (GetInFaction 71 COV_ThrallFaction == 0). Whether the player is a Vampire Lord is checked by
# giving the perk only then (COV_Thralls.UpdatePlayerPower).
SLEEP_LABEL = "Make your thrall"
SLEEP_DESC = "As a Vampire Lord, bind a sleeping person's will: they become your thrall."
perk_vmad = struct.pack('<hhH', 5, 2, 1) + script('PRKF_COV_SleepThrallPerk')
perk_vmad += b'\x02' + wstr('PRKF_COV_SleepThrallPerk') + struct.pack('<H', 1)           # fragments: version 2, file, one
perk_vmad += struct.pack('<HhB', 0, 0, 1) + wstr('PRKF_COV_SleepThrallPerk') + wstr('Fragment_0')
perk_body = (sub(b'EDID', zstr('COV_SleepThrallPerk')) + sub(b'VMAD', perk_vmad)
             + sub(b'FULL', zstr("Vampire Lord's Thrall")) + sub(b'DESC', zstr(SLEEP_DESC))
             + sub(b'DATA', bytes([0, 0, 1, 0, 1]))                                     # no trait, level 0, 1 rank, not playable, hidden
             + sub(b'PRKE', bytes([2, 0, 15]))                                          # entry point, rank 0, priority 15
             + sub(b'DATA', bytes([0x0E, 9, 2]))                                        # Activate, add a choice, 2 condition tabs
             + sub(b'PRKC', bytes([0])) + ctda(0x00, 0.0, 185)                          # owner: not swimming
             + sub(b'PRKC', bytes([1])) + ctda(0x00, 0.0, 46) + ctda(0x00, 0.0, 365)    # target: alive, no child
             + ctda(0x00, 1.0, 560, 0x013794) + ctda(0x00, 3.0, 49)                     # a person, asleep
             + ctda(0x00, 0.0, 71, 0x01000806)                                          # not a thrall yet
             + sub(b'EPFT', bytes([4])) + sub(b'EPF2', zstr(SLEEP_LABEL))
             + sub(b'EPF3', struct.pack('<HH', 0, 0))                                   # no flags, fragment 0
             + sub(b'PRKF', b''))
sleep_perk = record(b'PERK', 0x01000805, perk_body)
# every thrall of this mod: no relations, flag "hidden from PC"
thrall_faction = record(b'FACT', 0x01000806, sub(b'EDID', zstr('COV_ThrallFaction')) + sub(b'DATA', struct.pack('<I', 1)))

recs = quest(0x01000800, 'COV_BridgeQuest', 'CHIM Vampire Bridge', vmad_plain('COV_Bridge'))
recs += quest(0x01000801, 'COV_EventsQuest', 'CHIM Vampire Bridge Events', vmad_plain('COV_Events'))
recs += quest(0x01000802, 'COV_MCMQuest', 'CHIM Vampire Bridge MCM', vmad_mcm('COV_MCM', 0x01000802), alias=True)
grup = group(b'FACT', thrall_faction) + group(b'MGEF', mgef) + group(b'SPEL', spel) + group(b'PERK', sleep_perk) + group(b'QUST', recs)

hdr = sub(b'HEDR', struct.pack('<fII', 1.71, 12, 0x807))  # version 1.71, 7 records + 5 groups, next object id
hdr += sub(b'CNAM', zstr('SaurOff'))
hdr += sub(b'SNAM', zstr('CHIM Vampire Bridge - vampires, Vampire Lords, the bite, blood thirst and thralls for CHIM AI agents.'))
hdr += sub(b'MAST', zstr('Skyrim.esm')) + sub(b'DATA', b'\0' * 8)
tes4 = b'TES4' + struct.pack('<IIIIHH', len(hdr), 0x200, 0, 0, 44, 0) + hdr

os.makedirs(os.path.dirname(os.path.abspath(out)), exist_ok=True)
open(out, 'wb').write(tes4 + grup)
print("written", out, len(tes4 + grup), "bytes")
