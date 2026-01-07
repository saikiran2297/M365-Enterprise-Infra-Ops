<#
.SYNOPSIS
  Basic patching report (Windows Update history) for a server or local machine.
.DESCRIPTION
  Produces a CSV that can be attached to change records.
#>

param(
  [string]$ComputerName = $env:COMPUTERNAME,
  [string]$OutFile = ".\patching-report.csv"
)

try {
  Write-Host "Collecting update history from: $ComputerName" -ForegroundColor Cyan

  $session = New-Object -ComObject "Microsoft.Update.Session"
  $searcher = $session.CreateUpdateSearcher()
  $count = $searcher.GetTotalHistoryCount()
  $history = $searcher.QueryHistory(0, $count)

  $rows = $history | Select-Object `
    @{n="ComputerName";e={$ComputerName}},
    Date, Title, Description, ResultCode, HResult

  $rows | Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
  Write-Host "Saved patch report: $OutFile" -ForegroundColor Green
}
catch {
  Write-Error $_
  exit 1
}
