<#
.SYNOPSIS
  Collects basic triage data during outages (3rd line helper).
.DESCRIPTION
  Collects event logs (System/Application), IP config, routes, DNS settings, and services snapshot.
  Outputs a ZIP bundle for evidence sharing (sanitize before sharing externally).
#>

param(
  [string]$OutDir = ".\incident-bundle"
)

$ErrorActionPreference = "Stop"

try {
  New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

  "Collecting ipconfig..." | Out-Host
  ipconfig /all > (Join-Path $OutDir "ipconfig.txt")

  "Collecting routes..." | Out-Host
  route print > (Join-Path $OutDir "routes.txt")

  "Collecting DNS cache..." | Out-Host
  ipconfig /displaydns > (Join-Path $OutDir "dns-cache.txt")

  "Collecting running services..." | Out-Host
  Get-Service | Sort-Object Status,Name | Out-File (Join-Path $OutDir "services.txt")

  "Exporting event logs (last 24h)..." | Out-Host
  $since = (Get-Date).AddHours(-24)

  Get-WinEvent -FilterHashtable @{LogName='System'; StartTime=$since} |
    Export-Clixml (Join-Path $OutDir "system-last24h.xml")

  Get-WinEvent -FilterHashtable @{LogName='Application'; StartTime=$since} |
    Export-Clixml (Join-Path $OutDir "application-last24h.xml")

  $zipPath = "$OutDir.zip"
  if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
  Compress-Archive -Path "$OutDir\*" -DestinationPath $zipPath

  Write-Host "Incident bundle created: $zipPath" -ForegroundColor Green
}
catch {
  Write-Error $_
  exit 1
}
