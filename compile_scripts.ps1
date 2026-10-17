# CHIM Vampire Bridge - compiles src/Scripts/Source/*.psc into build/Scripts/*.pex.
#
#   .\compile_scripts.ps1 -Compiler "<folder with PapyrusCompiler.exe>" -GameData "<Skyrim>\Data"
#
# -Compiler   folder of Bethesda's PapyrusCompiler.exe. With the Creation Kit this is
#             "<Skyrim>\Papyrus Compiler"; the same compiler also ships with other tools
#             (the release was built with the copy bundled in Nemesis).
# -Flags      TESV_Papyrus_Flags.flg; looked up in -GameData\Source\Scripts,
#             -GameData\Scripts\Source and -Compiler\scripts when not given.
# -GameData   the game's Data folder. Its Scripts\Source and Source\Scripts must hold the
#             .psc sources of the base game (Creation Kit: extract Data\Scripts.zip),
#             SKSE, OStim Standalone, PapyrusUtil and CHIM (see DEPENDENCIES.md).
# -Imports    extra import folders, searched after the game's sources.
#
# The import order is: our sources, the game's sources, -Imports, stubs, stubs\vanilla.
# The compiler takes the first file it finds for a type, so real sources always win over
# the stubs; the stubs only fill in what is missing (no Creation Kit, no MCM Helper / SkyUI
# sources). Stubs are never packaged - the game uses the real scripts of those mods.

param(
    [Parameter(Mandatory = $true)][string]$Compiler,
    [Parameter(Mandatory = $true)][string]$GameData,
    [string]$Flags,
    [string[]]$Imports = @(),
    [string]$Out
)

$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
if (-not $Out) { $Out = Join-Path $root 'build\Scripts' }
$exe = Join-Path $Compiler 'PapyrusCompiler.exe'
if (-not (Test-Path $exe)) { throw "PapyrusCompiler.exe not found in $Compiler" }

if (-not $Flags) {
    $Flags = @(
        (Join-Path $GameData 'Source\Scripts\TESV_Papyrus_Flags.flg'),
        (Join-Path $GameData 'Scripts\Source\TESV_Papyrus_Flags.flg'),
        (Join-Path $Compiler 'scripts\TESV_Papyrus_Flags.flg')
    ) | Where-Object { Test-Path $_ } | Select-Object -First 1
    if (-not $Flags) { throw "TESV_Papyrus_Flags.flg not found, pass -Flags" }
}

$import = @(
    (Join-Path $root 'src\Scripts\Source'),
    (Join-Path $GameData 'Scripts\Source'),
    (Join-Path $GameData 'Source\Scripts')
) + $Imports + @(
    (Join-Path $root 'stubs'),
    (Join-Path $root 'stubs\vanilla')
) | Where-Object { Test-Path $_ }

New-Item -ItemType Directory -Force $Out | Out-Null
$failed = 0
foreach ($s in 'COV', 'COV_Config', 'COV_Bridge', 'COV_Events', 'COV_MCM', 'COV_Thralls', 'COV_EnthrallEffect') {
    $log = & $exe $s "-f=$Flags" "-i=$($import -join ';')" "-o=$Out" 2>&1 | ForEach-Object { "$_" }
    $ok = ($LASTEXITCODE -eq 0) -and ($log -match '0 failed')
    if ($ok) { Write-Host "$s.pex compiled" -ForegroundColor Green }
    else { $failed++; Write-Host "$s failed:" -ForegroundColor Red; $log | Where-Object { $_ -match '\.psc\(|error|failed' } | Write-Host }
}
if ($failed) { exit 1 }
Write-Host "Output: $Out"
