<#===============================================================================

     Title: O365-Email-Purge
    Author: O.C. Tanner Sys Admins
    

    This script, designed to be run via Jenkins, will connect to the 
    Exchange Online Security and Compliance Center and perform the 
    following tasks automatically:

        - Create a new compliance search using the input from Jenkins
        - Run the compliance search to check all O365 mailboxes
        - Record all O365 users who received the email
        - Email the report of affected users to the Sys Admins
        - Purge the email from all O365 mailboxes


================================================================================#>


<#=====================================================================

        Parameters

======================================================================#>

[CmdletBinding()]
param (
    [Parameter()]
    [string[]]$Ticket,

    [Parameter()]
    [string[]]$EmailSubject = $null,

    [Parameter()]
    [string[]]$EmailAddress = $null
    )


<#=====================================================================

        Import Credentials

======================================================================#>

#### Needs to be a Global Admin level credential. 


$AdminCreds = Get-Credential


<#=====================================================================

        Connect to O365 - Security and Compliance Center

======================================================================#>

$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri `
https://ps.compliance.protection.outlook.com/powershell-liveid -Credential $AdminCreds -Authentication Basic -AllowRedirection

Import-PSSession $Session -AllowClobber -DisableNameChecking


<#=====================================================================

        Main Script

======================================================================#>

### Instruct the script to stop if any errors occur.

$ErrorActionPreference = "Stop"


### Set the $SerachDate variable to 2 weeks ago. We'll use this to ensure we don't accidentally delete too much email.

$SearchDate = (get-date).AddDays(-14).ToString("MM/dd/yyyy")


### Check the values of both $EmailSubject and $EmailAddress to determine which variable was used. Set the value of $SearchType accordingly.

$SearchType = 0                                   # $SearchType will start out at 0, meaning both $EmailSubject and $EmailAddress are empty. 

if ($EmailSubject -ne $null){$SearchType = 1}     # If the $EmailSubject variable has any data stored in it (not equal to empty), set $SearchType to 1. 

if ($EmailAddress -ne $null){$SearchType = 2}      # If the $EmailAddress variable has any data stored in it (not equal to empty), set $SearchType to 2. 


### Now that we know which variable was used, we'll use $SearchType to create the appropriate Compliance Search. This won't actually start running the search, just stage it for us. 

switch($SearchType)
{
    (0){Write-Host "Did not find input of subject or email address"; break}

    (1){New-ComplianceSearch -Name "$Ticket" -ExchangeLocation all -ContentMatchQuery ("sent>=$SearchDate AND subject: $EmailSubject") | Out-Null}

    (2){New-ComplianceSearch -Name "$Ticket" -ExchangeLocation all -ContentMatchQuery ("sent>=$SearchDate AND senderauthor: $EmailAddress") | Out-Null}
}


### Start the Compliance Search we just prepared. 

Start-ComplianceSearch -Identity "$Ticket" | Out-Null


### Wait for compliance search to complete

Write-Host "Waiting for the Compliance Search to complete..."

do {Start-Sleep -Seconds 5} 
Until ((Get-ComplianceSearch -Identity "$Ticket").status -eq "Completed")


### Get the compliance search results and use various formatting techniques to extract the username's of all affected users. 

$mailboxes = @(); $export = @()  

$results = (Get-ComplianceSearch -Identity "$Ticket").SuccessResults
$lines = $results -split '[\r\n]+'

foreach ($line in $lines)
{
    if($line -match 'Location: (\S+),.+Item Count: (\d+)' -and $Matches[2] -gt 0)
    {
        $mailboxes += $Matches[1]
    }
}
 
foreach ($item in $mailboxes)
{
    $item = $item.Substring(0,$item.IndexOf('@'))
    $export += $item
}
 

### Export the data in $export to a file on the Jenkins server. The Jenkins job is setup to email this file as an attachment. 

$export | sort | Out-File -FilePath "C:\Program Files (x86)\Jenkins\jobs\O365 -- Purge Phishing Email\workspace\$Ticket-Affected-Users.txt"


### Delete (Purge) all messages that were found by the compliance search. 

New-ComplianceSearchAction -SearchName "$Ticket" -Purge -PurgeType SoftDelete -Confirm:$false | Out-Null


### Now that the script is complete, disconnect the Exchange Online session. 

Get-PSSession | Remove-PSSession