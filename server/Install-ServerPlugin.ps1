# CHIM Vampire Bridge by SaurOff - installs the server plugin into the CHIM server.
#
# CHIM's server (HerikaServer) runs inside a WSL distro, normally "DwemerAI4Skyrim3".
# This copies the "cov_vampire_bridge" folder next to this script into
# /var/www/html/HerikaServer/ext/ of that distro. The plugin registers its actions
# in CHIM's database by itself on the first request.

$ErrorActionPreference = 'Stop'
$src = Join-Path $PSScriptRoot 'cov_vampire_bridge'
if (-not (Test-Path $src)) {
    Write-Host "The folder 'cov_vampire_bridge' was not found next to this script." -ForegroundColor Red
    exit 1
}

# wsl -l -q prints UTF-16 with NUL bytes; clean it up
$distros = @(wsl.exe -l -q 2>$null | ForEach-Object { ($_ -replace "`0", '').Trim() } | Where-Object { $_ -ne '' })
$candidates = @('DwemerAI4Skyrim3') + $distros | Select-Object -Unique
$target = $null
foreach ($d in $candidates) {
    if ($distros -notcontains $d) { continue }
    wsl.exe -d $d -- test -d /var/www/html/HerikaServer/ext 2>$null
    if ($LASTEXITCODE -eq 0) { $target = $d; break }
}
if (-not $target) {
    Write-Host "No WSL distro with a CHIM server (/var/www/html/HerikaServer) was found." -ForegroundColor Red
    Write-Host "Install and start CHIM (DwemerAI) once, then run this again."
    exit 1
}

$winPath = ($src -replace '\\', '/')
$wslSrc = (wsl.exe -d $target -- wslpath -a "$winPath").Trim()
$ext = '/var/www/html/HerikaServer/ext'
$cmd = "rm -rf '$ext/cov_vampire_bridge' && cp -r '$wslSrc' '$ext/' && chown -R dwemer:www-data '$ext/cov_vampire_bridge' && chmod -R ug+rwX '$ext/cov_vampire_bridge'"
wsl.exe -d $target -u root -- bash -c $cmd
if ($LASTEXITCODE -ne 0) {
    Write-Host "Copying failed (exit code $LASTEXITCODE)." -ForegroundColor Red
    exit 1
}
Write-Host "CHIM Vampire Bridge server plugin installed into '$target' ($ext/cov_vampire_bridge)." -ForegroundColor Green
Write-Host "No restart needed: CHIM loads it on the next request."
