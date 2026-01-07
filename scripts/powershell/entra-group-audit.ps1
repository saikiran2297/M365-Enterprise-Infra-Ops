<#
.SYNOPSIS
  Exports Entra ID group membership for audit/review.
.DESCRIPTION
  Uses Microsoft Graph PowerShell. Produces CSV with group members.
.NOTES
  Requires: Install-Module Microsoft.Graph -Scope CurrentUser
  Permissions: Group.Read.All, User.Read.All (delegated)
#>

param(
  [Parameter(Mandatory=$true)][string]$GroupId,
  [string]$OutFile = ".\group-audit.csv"
)

try {
  Import-Module Microsoft.Graph.Groups -ErrorAction Stop
  Import-Module Microsoft.Graph.Users -ErrorAction Stop

  Connect-MgGraph -Scopes "Group.Read.All","User.Read.All" | Out-Null
  Select-MgProfile -Name "v1.0" | Out-Null

  $group = Get-MgGroup -GroupId $GroupId
  Write-Host "Auditing group: $($group.DisplayName) ($GroupId)" -ForegroundColor Cyan

  $members = Get-MgGroupMember -GroupId $GroupId -All

  $rows = foreach ($m in $members) {
    # Many directory objects; attempt to resolve to user properties where possible
    $id = $m.Id
    $user = $null
    try { $user = Get-MgUser -UserId $id -ErrorAction Stop } catch {}

    [pscustomobject]@{
      GroupDisplayName = $group.DisplayName
      GroupId          = $GroupId
      MemberId         = $id
      MemberType       = $m.AdditionalProperties.'@odata.type'
      UPN              = $user.UserPrincipalName
      DisplayName      = $user.DisplayName
      AccountEnabled   = $user.AccountEnabled
    }
  }

  $rows | Export-Csv -NoTypeInformation -Path $OutFile -Encoding UTF8
  Write-Host "Exported to $OutFile" -ForegroundColor Green
}
catch {
  Write-Error $_
  exit 1
}
finally {
  Disconnect-MgGraph | Out-Null
}
