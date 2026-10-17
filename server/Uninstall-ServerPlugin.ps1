# CHIM Vampire Bridge by SaurOff - removes the server plugin and its database rows
# (the six actions in core_action_custom and the bridge's settings/state in conf_opts).

$ErrorActionPreference = 'Stop'
$distros = @(wsl.exe -l -q 2>$null | ForEach-Object { ($_ -replace "`0", '').Trim() } | Where-Object { $_ -ne '' })
$candidates = @('DwemerAI4Skyrim3') + $distros | Select-Object -Unique
$target = $null
foreach ($d in $candidates) {
    if ($distros -notcontains $d) { continue }
    wsl.exe -d $d -- test -d /var/www/html/HerikaServer/ext 2>$null
    if ($LASTEXITCODE -eq 0) { $target = $d; break }
}
if (-not $target) {
    Write-Host "No WSL distro with a CHIM server was found." -ForegroundColor Red
    exit 1
}
$sql = "DELETE FROM core_action_custom WHERE code_name LIKE 'ExtCmdCOV_%'; DELETE FROM conf_opts WHERE id LIKE 'cov_vampire_bridge%';"
$cmd = "rm -rf /var/www/html/HerikaServer/ext/cov_vampire_bridge; sudo -u dwemer psql -d dwemer -c `"$sql`" || echo 'Database not reachable: start the CHIM server and run this again to remove the actions.'"
wsl.exe -d $target -u root -- bash -c $cmd
Write-Host "CHIM Vampire Bridge server plugin removed from '$target'." -ForegroundColor Green
