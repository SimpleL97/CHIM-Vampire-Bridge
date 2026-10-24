# Building CHIM Vampire Bridge

This repository holds everything the release is made from. Every file in the release
archive is either a source file from here, copied as is, or is generated from the
sources by the scripts below. Nothing is edited by hand after the build.

There are two ways to build:

- **Without the game** (Linux, WSL, macOS, GitHub Actions): one command, see
  [Build without the game](#build-without-the-game). Every GitHub release is built this way.
- **On Windows with Bethesda's compiler** and the game's script sources: steps 1-5 below.

## 1. What you need

- **Python 3.8+** - standard library only. On Windows use `py -3` or `python` instead of
  `python3` below; WSL works too.
- **Windows PowerShell 5.1+** (built into Windows) - for the Papyrus compile step.
- **Papyrus compiler** - `PapyrusCompiler.exe` and `TESV_Papyrus_Flags.flg`, from the free
  **Creation Kit** on Steam (`<Skyrim>\Papyrus Compiler\`; the base game sources come as
  `Data\Scripts.zip`, extract it into `Data`). The release was compiled with the same
  Bethesda compiler as bundled in *Nemesis Unlimited Behavior Engine*.
- **The mods this one calls into, installed in the game** - SKSE64, PapyrusUtil, CHIM and
  OStim Standalone (only to type-check the "is anyone in a scene" check, which is skipped
  without OStim in the game) install their `.psc` sources into `Data\Scripts\Source` or
  `Data\Source\Scripts`; the compiler reads them from there. SkyUI and MCM Helper sources
  are not needed (see `stubs/`).

Exactly what each dependency is used for: [DEPENDENCIES.md](DEPENDENCIES.md).

## 2. Build, step by step

Run everything from the repository root.

### Step 1 - the MCM menu and its translations (only after changing the menu)

```
python3 -I localize.py
```

Writes `mcm/config.json` (the MCM Helper menu, from the `MENU` layout in `localize.py`,
every text a `$COV_...` key) and `mcm/translations/CHIMVampireBridge_<LANGUAGE>.txt`
from the string table `T` (40 strings x 12 languages; UTF-16 LE with BOM, `$key<TAB>text`,
CRLF - the format SkyUI requires; 25 more game languages get a copy of English, because
SkyUI has no fallback). The outputs are committed; running it again changes nothing.

### Step 2 - the game plugin

```
python3 -I make_esp.py
```

Writes `build/CHIMVampireBridge.esp`, byte by byte and the same on every run. ESL flagged, master `Skyrim.esm` only, author SaurOff.

| FormID | Record | Purpose |
|---|---|---|
| `xx000800` | QUST `COV_BridgeQuest` + script `COV_Bridge` | the AI's actions |
| `xx000801` | QUST `COV_EventsQuest` + script `COV_Events` | state for the server, infections, the player's power, moving in from CHIM OStim Bridge 1.x |
| `xx000802` | QUST `COV_MCMQuest` + `COV_MCM`, player alias with `SKI_PlayerLoadGameAlias` | MCM menu |
| `xx000803` | MGEF `COV_ThrallEffect` + script `COV_EnthrallEffect` | the bite of the lesser power (script archetype, self) |
| `xx000804` | SPEL `COV_ThrallPower` | lesser power "Vampire's Thrall" (shout key), given to a Vampire Lord player; raises the dead |
| `xx000805` | PERK `COV_SleepThrallPerk` + fragment `PRKF_COV_SleepThrallPerk` | "Make your thrall" next to Feed on a sleeping person (Activate entry point, like `VampireFeed`), given to a Vampire Lord player |
| `xx000806` | FACT `COV_ThrallFaction` | every thrall of this mod (keeps "Make your thrall" off them); thralls of living blood also join Dawnguard's `DLC1ThrallFaction` for the game's own Feed |

The quests are technical script holders: start-game-enabled, no stages, no journal entries.
The lesser power is laid out like the vanilla `PowerKhajiitNightEye`.

### Step 3 - compile the Papyrus scripts

```
powershell -ExecutionPolicy Bypass -File compile_scripts.ps1 -Compiler "<folder with PapyrusCompiler.exe>" -GameData "<Skyrim>\Data"
```

Compiles `COV`, `COV_Config`, `COV_Bridge`, `COV_Events`, `COV_MCM`, `COV_Thralls` and
`COV_EnthrallEffect` into `build/Scripts/*.pex`. Import order: `src/Scripts/Source`, the
game's `Data\Scripts\Source` and `Data\Source\Scripts`, any `-Imports`, then `stubs` and
`stubs/vanilla`. The compiler takes the first file it finds
for each type. Options: `-Flags <path to .flg>`, `-Out <folder>`.

Bethesda's compiler writes the compile time and an unordered string table into each
`.pex`, so two compiles never match byte for byte; the size and the code are the same.

### Step 4 - package

```
python3 -I build.py [release folder]
```

Checks that the version is the same in all four places (see *Versioning*), builds the
CHIM server plugin package `build/cov_vampire_bridge-<version>.dwpkg`, lays out the FOMOD
tree in `build/stage/` and zips it to `<release folder>/CHIM Vampire Bridge.zip` (default
`release/`). An older version found there is moved to `archive/CHIM Vampire Bridge-<old
version>.zip` first.

### Step 5 - check the archive

```
python3 -I verify_release.py "release/CHIM Vampire Bridge.zip" [<HerikaServer/ext/cov_vampire_bridge>] [<Data>]
```

Compares every file in the zip with its source or build output, checks that each `.pex` is
newer than its `.psc` and that every translation file has every menu key; optionally also
against a live CHIM server plugin folder and an installed game `Data` folder.

## Build without the game

```
tools/build_linux.sh <papyrus-compiler binary> [release folder]
```

Needs Python 3.8+ and the open-source [papyrus-compiler](https://github.com/russo-2025/papyrus-compiler)
(MIT). Its release 0.0.4 still stores string escapes such as `\"` literally, which breaks
the scripts' JSON; use a build of commit `b9dc995` or later (the fix for its issue 19).
Building it from source takes a few seconds with [V](https://github.com/vlang/v/releases/tag/0.5.1)
0.5.1 - the same commands as in `.github/workflows/release.yml`:

```
git clone https://github.com/russo-2025/papyrus-compiler.git
cd papyrus-compiler && git checkout b9dc9951f4264084c8ded6721b20f0d81c021d58
<path to v>/v -prod -gc none -o bin/papyrus-compiler compiler.v
```

The script runs step 2 (`make_esp.py`), compiles every script in `src/Scripts/Source`
against the declaration-only headers in `stubs/` (the generated `stubs/headers` and the
hand-written ones) instead of the game's sources, and runs step 4 (`build.py`); the
archive goes to `dist/` by default. The headers in `stubs/headers` are written by

```
python3 -I tools/gen_headers.py "<Skyrim>/Data/Scripts/Source" "<Skyrim>/Data/Source/Scripts"
```

from the installed sources of the base game, SKSE, OStim Standalone, PapyrusUtil and
CHIM: only the types the mod uses, only their signatures, no code. Re-run it when a
script starts using a type it did not use before (the build then fails with an
"undefined" error).

Checked against the Bethesda build of the same sources: every function calls the same
functions with the same arguments and string literals, and every script has the same
parent, flags, variables, properties and function signatures.

## Releasing

`.github/workflows/release.yml` builds the mod on GitHub; no built files are kept in the
repository. Every push and pull request builds the whole mod and keeps the archive as the
run's artifact *CHIM Vampire Bridge* (Actions tab -> the run -> Artifacts). To release:
change the version (see *Versioning*), commit, tag the commit `v<version>`, push both and
publish a GitHub release from the tag - the workflow builds the tagged commit, checks
that its version matches the tag and attaches `CHIM Vampire Bridge.zip` to the release.

## 3. Where every file in the release comes from

| In the release zip | Source in this repository | Made by |
|---|---|---|
| `fomod/info.xml`, `fomod/ModuleConfig.xml` | `fomod/` | copied |
| `fomod/images/banner.jpg` (installer picture) | `art/make_banner.py` -> `art/render_banner.ps1` | rendered, committed |
| `README.txt`, `CHANGELOG.txt` | `docs/` | copied |
| `00 Core/CHIMVampireBridge.esp` | `make_esp.py` | step 2 |
| `00 Core/Scripts/COV*.pex` | `src/Scripts/Source/COV*.psc` | step 3 |
| `00 Core/MCM/Config/CHIMVampireBridge/config.json`, `settings.ini` | `mcm/` | copied (config.json from step 1) |
| `00 Core/Interface/Translations/CHIMVampireBridge_*.txt` | `mcm/translations/` | copied (from step 1) |
| `00 Core/CHIM/server-plugins/cov_vampire_bridge/<version>.dwpkg` | `server/cov_vampire_bridge/*` | step 4 |
| `10 Server Tools/CHIM Vampire Bridge Server Tools/*.bat, *.ps1` | `server/*.bat`, `server/*.ps1` | copied |
| `10 Server Tools/CHIM Vampire Bridge Server Tools/cov_vampire_bridge/*` | `server/cov_vampire_bridge/*` | copied |
| `20 Source/Source/Scripts/COV*.psc` | `src/Scripts/Source/` | copied |

FOMOD options: `00 Core` is always installed; `10 Server Tools` (manual install of the
server plugin, for CHIM versions that do not install bundled server plugins) and
`20 Source` (the `.psc` files) are optional.

### The `.dwpkg` server package

A plain zip in the format CHIM's `ServerPluginSync` / `DwemerPluginPackageManager` reads:
`manifest.json` (`schema_version` 4, name `cov_vampire_bridge`, version, author,
`server.mutable_paths`), `checksums.sha256` (sha256 of every other file) and
`server/cov_lib.php, context_pre.php, functions.php, manifest.json, preprocessing.php,
prompts.php` - the same files as in `server/cov_vampire_bridge/`. CHIM uploads it from
`Data/CHIM/server-plugins/cov_vampire_bridge/<version>.dwpkg` at game start and unpacks
`server/` to `HerikaServer/ext/cov_vampire_bridge/`, only when the version changes.

### The `.bat` / `.ps1` server tools

`Install-ServerPlugin.bat` starts `Install-ServerPlugin.ps1`, which finds the WSL distro
running the CHIM server (normally `DwemerAI4Skyrim3`) and copies the `cov_vampire_bridge`
folder next to it into `/var/www/html/HerikaServer/ext/`. `Uninstall-ServerPlugin.*`
removes that folder and the mod's six actions and stored settings and state from CHIM's
database (`core_action_custom` rows `ExtCmdCOV_*`, `conf_opts` rows
`cov_vampire_bridge*`). Nothing else; read them in `server/`.

## 4. Versioning

The version must be the same in four places - `build.py` stops if they differ:
`server/cov_vampire_bridge/cov_lib.php` (`COV_VERSION`), `server/cov_vampire_bridge/manifest.json`,
`fomod/info.xml` (`MachineVersion` and the text) and `src/Scripts/Source/COV_Config.psc`
(`Version()`). Also update `docs/CHANGELOG.txt`, the version line in `docs/README.txt` and
`VERSION` in `localize.py` (the menu title). Every published change needs a new version:
CHIM only re-installs the server package when the version changes.

## 5. The banner

`python3 -I art/make_banner.py` writes `art/banner.svg` / `banner.html` (original artwork,
no third-party logos); `art/render_banner.ps1` renders it with Microsoft Edge headless to
`art/banner.png` (1920x1080: README and Nexus) and `fomod/images/banner.jpg` (1280x720: the
picture the FOMOD installer shows in Vortex and MO2). Both pictures are committed.
README.md shows the banner by its address at a fixed commit (GitHub keeps serving a cached
copy under the plain path for a while): after committing a new banner, put that commit in
the README link.

## 6. Quick test in game

1. Install the release zip with Vortex or MO2.
2. Start the CHIM server, then the game, and load a save.
3. `SKSE/AIAgent.log` should contain `[SERVER_PLUGIN_SYNC] Installed cov_vampire_bridge`.
4. The MCM *CHIM Vampire Bridge* appears; turn on *Show notifications* and ask a vampire
   follower to drink from you - the Feed_On_Blood result shows in the top left corner, and
   `Data/SKSE/Plugins/CHIMVampireBridge.log` has the whole exchange.
