# Disconecta do Graph

Disconnect-MgGraph

# PowerShell Modules
Install-Module MsolService
Install-Module Microsoft.Graph.Users
Install-Module Microsoft.Graph.Users.Actions
Install-Module Microsoft.Graph.Identity.DirectoryManagement



<#
# Graph Permissions
User.ReadBasic.All
User.Read
User.ReadWrite
User.Read.All
Directory.Read.All
#>

# Connection
Connect-Graph -scopes User.ReadWrite.All
Connect-Graph -scopes Directory.ReadWrite.All
Connect-Graph -scopes Directory.AccessAsUser.All
Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All


# Get M365 Domains
Get-MsolDomain

# Get Licenses
Get-MsolAccountSku



## User Creation

# Counters
$i = 0
$count = 92

import-csv 'C:\temp\listOfUsers.csv' -Encoding UTF8 -Delimiter ";" | foreach {

$i++

# For individual password for each Users, bring the password from CSV file
# For standand password, just set on the variavel has follow
$PasswordProfile = @{
  Password = $_.Pass
  }

New-MgUser -DisplayName $_.DisplayName -PasswordProfile $PasswordProfile -AccountEnabled -MailNickName $_.Login -UserPrincipalName $_.UPN -UsageLocation "BR" -EmployeeId $_.EmployID -OfficeLocation $_.Office -JobTitle "ALUNO" -Department $_.SEGMENTO
Set-MgUserLicense -UserId $_.UPN -AddLicenses @{SkuId = '18250162-5d87-4436-a834-d795c15c80f3'} -RemoveLicenses @()

Write-Host "$i"

}