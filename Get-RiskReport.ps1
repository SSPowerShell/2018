
<#=====================================================================

        Variables

======================================================================#>

$ClientID       = "insert GUID here"        # Should be a ~36 hex character string; insert your info here
$ClientSecret   = "insert secret here="    # Should be a ~44 character string; insert your info here
$tenantdomain   = "insert domain here"    # For example, contoso.onmicrosoft.com

$loginURL       = "https://login.microsoft.com"
$resource       = "https://graph.microsoft.com"

$body       = @{grant_type="client_credentials";resource=$resource;client_id=$ClientID;client_secret=$ClientSecret}
$oauth      = Invoke-RestMethod -Method Post -Uri $loginURL/$tenantdomain/oauth2/token?api-version=1.0 -Body $body
$time = Get-Date 

$Days = "Monday","Tuesday","Wednesday","Thursday","Friday"


Set-Location $PSScriptRoot

$ActiveEvents = Get-Content .\Active-Events.txt


<#=====================================================================

        Main Script - Get Risk Events, Send Emails

======================================================================#>

#### Check if the token is valid. If so, get the Azure risk reports. 

if ($oauth.access_token -ne $null)
{
    $headerParams = @{'Authorization'="$($oauth.token_type) $($oauth.access_token)"}
    $url = "https://graph.microsoft.com/beta/identityRiskEvents"
    $myReport = (Invoke-WebRequest -UseBasicParsing -Headers $headerParams -Uri $url)
}

else {Write-Host "ERROR: No Access Token"; break } 


#### Evaluate each event and setup email templates with user info

foreach ($event in ($myReport.Content | ConvertFrom-Json).value) {
    
    ### Check if the event's alert has already been sent

    if ($event.id -notin $ActiveEvents -and $event.riskEventStatus -eq "active")
    {

        ### TYPE 1 - Impossible Travel

        if ($event.riskEventStatus -eq "active" -and $event.riskEventType -eq "ImpossibleTravelRiskEvent")
        {
            $Manager = (Get-ADUser -Identity ($event.userPrincipalName.Replace("@octanner.com","")) -Properties manager).manager
            $ManagerEmail = (Get-ADUser -Identity $Manager).UserPrincipalName

                #### Option to Disable user account if alerted on Impossible travel Ensure that you change the yourdomain place holder
            #  Disable-ADAccount -Identity ($event.userPrincipalName.Replace("@yourdomain.com","")) -Confirm:$false 

            .\Send-RiskAlert.ps1 -Type T1 -Event $event -ManagerEmail $ManagerEmail
        }


        ### TYPE 2 - Malware Risk, TYPE 3 - Suspicious IP, TYPE 4 - Anonymous IP

        if ($event.riskEventStatus -eq "active" -and $event.riskEventType -ne "ImpossibleTravelRiskEvent" -and $time.TimeOfDay.Hours -ge 7 -and $time.TimeOfDay.Hours -lt 17 -and $time.DayOfWeek -in $Days)
        {
            Switch ($event.riskEventType)
            {
                ("MalwareRiskEvent"){.\Send-RiskAlert.ps1 -Type T2 -Event $event}
                ("SuspiciousIpRiskEvent"){.\Send-RiskAlert.ps1 -Type T3 -Event $event}
                ("AnonymousIpRiskEvent"){.\Send-RiskAlert.ps1 -Type T4 -Event $event}
            }
        }

        ### Write the active event to the text file to prevent repeat emails

        $event.id >> .\Active-Events.txt
    }
} 
