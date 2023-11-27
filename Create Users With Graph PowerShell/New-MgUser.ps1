# Created by EDSON MARTINS


# Disconnect from Graph

Disconnect-MgGraph

# Power Shell Modules needed
Install-Module MsolService
Install-Module Microsoft.Graph.Users
Install-Module Microsoft.Graph.Users.Actions
Install-Module Microsoft.Graph.Identity.DirectoryManagement


# Graph Permissions
<#
User.ReadBasic.All
User.Read
User.ReadWrite
User.Read.All
Directory.Read.All
#>

# Power Shell Modules Connections
Connect-Graph -scopes User.ReadWrite.All
Connect-Graph -scopes Directory.ReadWrite.All
Connect-Graph -scopes Directory.AccessAsUser.All
Connect-Graph -Scopes User.ReadWrite.All, Organization.Read.All

# Get Tenant Domains
Get-MsolDomain

# Get Tenant Licenses
Get-MsolAccountSku

## Criação de Usuários

## Required Fields
# DisplayName == Full Name
# MailNickName == frodo (E.G. from frodo@domain.com)
# UserPrincipalName == frodo@domain.com
# UsageLocation == Your Country
# SkuId = SkuId of the license you will use


#Counters

$i = 0
$count = 92 # number of lines of the csv file

import-csv 'C:\temp\listOFUsers.csv' -Encoding UTF8 -Delimiter ";" | foreach {

$i++

# For this method of Users Creation is required a PasswordProfile with at least a Password
# Two ways to use it
# First, with an individual password for each user that come from a column
# Or, set a standard password 
# For more information visit https://learn.microsoft.com/en-us/graph/api/resources/passwordprofile?view=graph-rest-1.0

$PasswordProfile = @{
  Password = $_.Pass # or Password = "Userpassword"
  }

New-MgUser -DisplayName $_.DisplayName -PasswordProfile $PasswordProfile -AccountEnabled -MailNickName $_.Login -UserPrincipalName $_.UPN -UsageLocation "BR" 
Set-MgUserLicense -UserId $_.UPN -AddLicenses @{SkuId = '18250162-5d87-4436-a834-d795c15c80f3'} -RemoveLicenses @()

Write-Host "$i"

}
