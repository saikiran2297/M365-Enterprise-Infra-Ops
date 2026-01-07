<#
.SYNOPSIS
  Demonstration script: AD user provisioning (Joiner workflow).
.DESCRIPTION
  Creates a user in a target OU, sets UPN, enables account, and adds to groups.
  Designed for lab/on-prem AD DS. Use in a test domain only.
#>

param(
  [Parameter(Mandatory=$true)][string]$GivenName,
  [Parameter(Mandatory=$true)][string]$Surname,
  [Parameter(Mandatory=$true)][string]$SamAccountName,
  [Parameter(Mandatory=$true)][string]$UserPrincipalName,
  [Parameter(Mandatory=$true)][string]$TargetOU, # e.g. "OU=Users,OU=Corp,DC=lab,DC=local"
  [string[]]$Groups = @()
)

Import-Module ActiveDirectory -ErrorAction Stop

try {
  $displayName = "$GivenName $Surname"

  Write-Host "Creating AD user: $displayName ($SamAccountName)" -ForegroundColor Cyan

  New-ADUser `
    -Name $displayName `
    -GivenName $GivenName `
    -Surname $Surname `
    -DisplayName $displayName `
    -SamAccountName $SamAccountName `
    -UserPrincipalName $UserPrincipalName `
    -Path $TargetOU `
    -Enabled $true `
    -ChangePasswordAtLogon $true `
    -AccountPassword (Read-Host "Enter temp password" -AsSecureString)

  if ($Groups.Count -gt 0) {
    foreach ($g in $Groups) {
      Write-Host "Adding user to group: $g"
      Add-ADGroupMember -Identity $g -Members $SamAccountName
    }
  }

  Write-Host "Done. Verify: Get-ADUser $SamAccountName -Properties memberof,Enabled,UserPrincipalName" -ForegroundColor Green
}
catch {
  Write-Error $_
  exit 1
}
