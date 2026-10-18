# Dependencies

What CHIM Vampire Bridge needs, and exactly what each piece is used for.
None of these are bundled: the release ships only this mod's own files.

## To play

| Dependency | Link | Why it is needed |
|---|---|---|
| **Skyrim Special / Anniversary Edition** | - | The game. Tested on 1.6.1170. `Skyrim.esm`: the disease `DiseaseSanguinareVampiris` (0x0B8780), the `Vampire` keyword (0x0A82BB), `PlayerVampireQuest` (0x0EAFD5, `PlayerVampireQuestScript.VampireChange`) and `C00` (0x04B2D9, `CompanionsHousekeepingScript`: a werewolf player is cured, as in Dawnguard). |
| **Dawnguard** (DLC) | part of every SE/AE install | The feeding idle `IdleVampireStandingFeedFront_Loose` (0x00E6A8) used by every bite; for the Vampire Lord's gift the power `DLC1VampireChange` (0x00283B) and the perk `DLC1VampireTurnPerk` (0x00588B) - the same steps as `DLC1VampireTurnScript.ReceiveHarkonsGift`, with the bite played to its end first; the race `DLC1VampireBeastRace` (0x00283A); the base records of the game's own Vampire Lords; the Volkihar court faction `DLC1VampireFaction` (0x003376). |
| **SKSE64** | [skse.silverlock.org](https://skse.silverlock.org/) | Script extender: `RegisterForModEvent` (CHIM commands), `ModEvent`, `GetDisplayName`, `StringUtil`, `Game.GetCurrentCrosshairRef` (whom the player's lesser power bites), `ActorBase.SetProtected` (Spare). |
| **Address Library for SKSE Plugins** | [Nexus 32444](https://www.nexusmods.com/skyrimspecialedition/mods/32444) | Not used by this mod directly; CHIM's SKSE plugin needs it. |
| **CHIM** (game plugin **and** server) | [Nexus 126330](https://www.nexusmods.com/skyrimspecialedition/mods/126330) | The AI side. In the game: CHIM delivers the chosen actions by calling the global `COV.DispatchExternalCommand` (fallback: the mod event `CHIM_CommandReceived`, heard too); `AIAgentFunctions` for `getAgentByName`, `getClosestAgent`, `logMessageForActor` (each action's result, to the agent that chose it), `requestMessage` (events and silent state) and `isActorTalking` (a bite waits for the line that announces it). On the server: the `ext/cov_vampire_bridge` plugin hooks into CHIM's request pipeline (`preprocessing.php`, `functions.php`, `prompts.php`, `context_pre.php` with `chimRegisterPromptInjection`) and keeps its actions and state in CHIM's database (`core_action_custom`, `conf_opts`). CHIM's `ServerPluginSync` installs the bundled `Data/CHIM/server-plugins/cov_vampire_bridge/<version>.dwpkg` at game start. Tested with 3.4.2. |
| **PapyrusUtil SE/AE** | [Nexus 13048](https://www.nexusmods.com/skyrimspecialedition/mods/13048) | `MiscUtil.ScanCellNPCs` (vampires and named people near the player), `MiscUtil.WriteToFile` (the log file), `StorageUtil` (bitten, turned and thrall NPCs, kept in the save). |
| **SkyUI** | [Nexus 12604](https://www.nexusmods.com/skyrimspecialedition/mods/12604) | The MCM framework (`SKI_ConfigBase`, `SKI_PlayerLoadGameAlias`) and the `Interface/Translations` loader. |
| **MCM Helper** | [Nexus 53000](https://www.nexusmods.com/skyrimspecialedition/mods/53000) | Builds the MCM from `MCM/Config/CHIMVampireBridge/config.json` and stores the settings (`MCM.GetModSetting*`; `SetModSettingString` once, to bring over the NPC name lists of CHIM OStim Bridge 1.x). |

## Optional, supported: my other CHIM bridges

Built the same way, by the same author, and tested together with this one.

| Mod | What works together |
|---|---|
| **CHIM OStim Bridge** ([Nexus](https://www.nexusmods.com/skyrimspecialedition/mods/194761) · [GitHub](https://github.com/SimpleL97/CHIM-OStim-Bridge)) | Reads this mod's StorageUtil list `COV_Thralls`, so a thrall can be undressed, dressed and brought into OStim scenes by name - also a thrall who is not an AI agent; the thrall prompt here mentions that only when it is installed. |
| **CHIM ORomance Bridge** ([GitHub](https://github.com/SimpleL97/CHIM-ORomance-Bridge)) | Love, marriage and children through ORomance Plus; weddings, pregnancies and births reach the agents here, and a thrall bound or an NPC turned reaches the agents there. |

None of them is required and none requires another; each works on its own. Installed together they
see each other: in the game they share only the StorageUtil list `COV_Thralls`; on the CHIM
server each plugin reads another one's settings only when that plugin's folder exists in
`HerikaServer/ext` and it is switched on in its MCM. Events of every bridge go to CHIM's shared
event log, so every AI agent nearby can talk about what happened in another one.

## Also optional

- **OStim Standalone** - not needed; when it is installed, nobody is bitten or enthralled in
  the middle of a scene.
- **Surrender - Enemies Yield and Comply with Your Demands**
  ([Nexus 139522](https://www.nexusmods.com/skyrimspecialedition/mods/139522)) - enemies kneel
  and give up at low health. With it, an enemy kneeling in surrender (its spell
  `DBSurrenderMarker`, 0x000807 in `DB Surrender.esp`) counts as a captive here: the nearest
  Vampire Lord hears of them and can bind them; a spared one stays protected while kneeling
  (Surrender makes them essential only for the time being); a bite first frees them from
  Surrender's hold so the feeding animation can play. Found by the plugin name; nothing of
  it is needed to build or to play.

## To build

See [BUILDING.md](BUILDING.md) for the steps.

| Tool / file | Used for |
|---|---|
| **Python 3.8+** (standard library only) | `make_esp.py`, `localize.py`, `build.py`, `verify_release.py`, `tools/gen_headers.py`, `art/make_banner.py`. |
| **Papyrus compiler** | Compiling `src/Scripts/Source/*.psc`. Either the open-source [papyrus-compiler](https://github.com/russo-2025/papyrus-compiler) (MIT; Linux, macOS, Windows; what the GitHub releases are built with, from commit `b9dc995`) or Bethesda's `PapyrusCompiler.exe` + `TESV_Papyrus_Flags.flg` from the free Creation Kit (Steam), also bundled in Nemesis Unlimited Behavior Engine. |
| **V** 0.5.1 (only to build papyrus-compiler from source) | [github.com/vlang/v](https://github.com/vlang/v/releases/tag/0.5.1). |
| **Windows PowerShell 5.1+** | `compile_scripts.ps1` (Bethesda's compiler), `art/render_banner.ps1`. |
| **Papyrus sources of the base game, SKSE, PapyrusUtil, CHIM, OStim Standalone** | Type checking only, with Bethesda's compiler; without the game, `stubs/headers` stands in for them. |
| **Microsoft Edge** or any Chromium browser (optional) | Rendering the banner. |

### About the stubs

`stubs/` holds declaration-only `.psc` files: script names and function signatures, no
code. They exist only so the compiler can type-check calls into SkyUI, MCM Helper and a few
base game types when their sources are not installed. `stubs/headers` is generated by
`tools/gen_headers.py` from the installed sources of the base game, SKSE, OStim Standalone,
PapyrusUtil and CHIM - only the types this mod uses - so the mod builds without the game
(GitHub Actions). They are never compiled into the release and never shipped; in the game
the real scripts of those mods run. They describe the public APIs of their owners (Bethesda,
the SkyUI team, Exit-9B and the others) and are not covered by this repository's license.
