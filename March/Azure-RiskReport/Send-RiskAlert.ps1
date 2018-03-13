
<#=====================================================================

        Parameters

======================================================================#>

[CmdletBinding()]
    param
    (
        [parameter()]
        [ValidateSet("T1","T2","T3","T4")]
        [string]$Type,

        [parameter()]
        $Event,

        [parameter()]
        [string]$ManagerEmail = $null
    )


<#=====================================================================

        Email Templates

======================================================================#>


### TYPE 1 -- Impossible Travel Email 

$t1 = 'corad@octanner.com,infosec@octanner.com,corad@octanner.opsgenie.net'

$s1 = "RISK ALERT: Impossible Travel"

$b1 = @"
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><meta http-equiv=Content-Type content="text/html; charset=us-ascii"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><p class=MsoNormal>Our Azure AD tenant reporting has triggered on an Impossible Travel alert for <b>$($event.userDisplayName)</b>. <o:p></o:p></p><p class=MsoNormal>Please reach out to <b>$($event.userDisplayName)</b> and help them reset their password and put in an ISSD ticket following the &nbsp;ISSD-Process article:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://confluence.octanner.com/confluence/display/SDKB/First+Five+Steps+-+Impossible+Travel+or+Irregular+Sign-in">https://confluence.octanner.com/confluence/display/SDKB/First+Five+Steps+-+Impossible+Travel+or+Irregular+Sign-in</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>Alert Information:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>User name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.userDisplayName)</b><o:p></o:p></p><p class=MsoNormal>Email address: &nbsp; <b>$($event.userPrincipalName)</b><o:p></o:p></p><p class=MsoNormal>1<sup>st</sup> IP Address: &nbsp;&nbsp; <b>$($event.previousIpAddress)</b><o:p></o:p></p><p class=MsoNormal>1<sup>st</sup> Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.previousLocation.city + " " + $event.previousLocation.state)</b><o:p></o:p></p><p class=MsoNormal>1<sup>st</sup> Timestamp: &nbsp;<b>$($event.previousSigninDateTime)</b><o:p></o:p><p class=MsoNormal>2<sup>nd</sup> IP Address:&nbsp; <b>$($event.ipAddress)</b><o:p></o:p></p><p class=MsoNormal>2<sup>nd</sup> Location: &nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.location.city + " " + $event.location.state)</b><o:p></o:p></p><o:p></o:p></p><p class=MsoNormal>2<sup>nd</sup> Timestamp: &nbsp;<b>$($event.createdDateTime)</b><o:p></o:p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>CORAD Action Required:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>You need to login Azure AD Portal with the link below: <o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017">https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><ol style='margin-top:0in' start=1 type=1><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Azure Active Directory blade from the left pane.<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Under Security click on Risky sign-ins<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Risk Type Event associated with this alert<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Context Menu for the User that is reported (the three dots next to the Status column &#8230;)<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Resolve to Close this alert so that we do not get repeat email alerts. <o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Refresh within the Risk Event blade to ensure that the alert gets closed (you may need to wait 5 seconds and refresh again to have the alert show as closed)<o:p></o:p></li></ol><p class=MsoListParagraph><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
"@


## Impossible Travel - Manager Email 

$MSubject = "$($Event.userDisplayName) - Account Disabled"

$MBody = @"
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"><meta name="Generator" content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1551182671;
	mso-list-type:hybrid;
	mso-list-template-ids:1678008454 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style></head><body lang="EN-US" link="#0563C1" vlink="#954F72"><div class="WordSection1"><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">Our IT security systems have detected some suspicious behavior using $($event.userDisplayName)’s O.C. Tanner network account. As a precaution, the Service Desk has temporarily disabled $($event.userDisplayName)’s account.<o:p></o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">To reactivate $($event.userDisplayName)’s network account, they will need to contact the Service Desk. Please ensure that $($event.userDisplayName) communicates with the Service Desk team as soon as possible to avoid unnecessary disruption to their work. They will need to reset their O.C Tanner network password, which should only take a few minutes. &nbsp;<o:p></o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif">The Service Desk can be reached at the following number: &nbsp;&nbsp;&#43;1 (801) 483-8235 or extension 38235<o:p></o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Please note that until this employee re-activates their account with the Service Desk, the following O.C. Tanner services will be unavailable:<o:p></o:p></span></p><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><ul style="margin-top:0in" type="disc"><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">All O.C. Tanner Email (including email on mobile devices, and webmail) <o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">OCT-WiFi Internet Access<o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Shared Drive Documents and Files<o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Jabber Messages<o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">Skype Messages<o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">My OC Tanner Webpage<o:p></o:p></span></li><li class="MsoListParagraph" style="margin-left:0in;mso-list:l0 level1 lfo1"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">All Box.com Usage<o:p></o:p></span></li></ul><p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoNormal"><span style="font-size:14.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p><p class="MsoListParagraph"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p></div></body></html>
"@



### TYPE 2 -- Malware Infection Email

$t2 = 'corad@octanner.com,infosec@octanner.com'

$s2 = "RISK ALERT: Infected Computer"

$b2= @"
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><p class=MsoNormal>Our Azure AD tenant reporting has triggered on an Login from an infected device alert for <b>$($event.userDisplayName)</b>. <o:p></o:p></p><p class=MsoNormal>Please put in an ISSD ticket following the &nbsp;ISSD-Process article:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://confluence.octanner.com/confluence/display/SDKB/ISSD-+Process+-+Login+from+infected+device">https://confluence.octanner.com/confluence/display/SDKB/ISSD-+Process+-+Login+from+infected+device</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>Alert Information:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>User name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.userDisplayName)</b><o:p></o:p></p><p class=MsoNormal>Email address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.userPrincipalName)</b><o:p></o:p></p><p class=MsoNormal>IP Address: &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.ipAddress)</b><o:p></o:p></p><p class=MsoNormal>Name of Malware:&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; <b>$($event.malwareName)</b><o:p></o:p></p><p class=MsoNormal>Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.location.city + " " + $event.location.state)</b><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>CORAD Action Required:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>You need to login Azure AD Portal with the link below: <o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017">https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><ol style='margin-top:0in' start=1 type=1><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Azure Active Directory blade from the left pane.<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Under Security click on Risky sign-ins<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Risk Type Event associated with this alert<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Context Menu for the User that is reported (the three dots next to the Status column &#8230;)<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Resolve to Close this alert so that we do not get repeat email alerts. <o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Refresh within the Risk Event blade to ensure that the alert gets closed (you may need to wait 5 seconds and refresh again to have the alert show as closed)<o:p></o:p></li></ol><p class=MsoListParagraph><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>
"@


### TYPE 3 -- Suspicious IP Email 

$t3 = 'corad@octanner.com,infosec@octanner.com'

$s3 = "RISK ALERT: Suspicious IP Address"

$b3 = @"
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><p class=MsoNormal>Our Azure AD tenant reporting has triggered on an Login from a suspicious IP Address Alert for <b>$($event.userDisplayName)</b>. <o:p></o:p></p><p class=MsoNormal>Please put in an ISSD ticket following the &nbsp;ISSD-Process article:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://confluence.octanner.com/confluence/display/SDKB/ISSD+-Process+-+Login+from+a+Suspicious+IP+Address">https://confluence.octanner.com/confluence/display/SDKB/ISSD+-Process+-+Login+from+a+Suspicious+IP+Address</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>Alert Information:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>User name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.userDisplayName)</b><o:p></o:p></p><p class=MsoNormal>Email address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.userPrincipalName)</b><o:p></o:p></p><p class=MsoNormal>IP Address: &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.ipAddress)</b><o:p></o:p></p><p class=MsoNormal>Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.location.city + " " + $event.location.state)</b><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>CORAD Action Required:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>You need to login Azure AD Portal with the link below: <o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017">https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><ol style='margin-top:0in' start=1 type=1><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Azure Active Directory blade from the left pane.<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Under Security click on Risky sign-ins<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Risk Type Event associated with this alert<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Context Menu for the User that is reported (the three dots next to the Status column &#8230;)<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Resolve to Close this alert so that we do not get repeat email alerts. <o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Refresh within the Risk Event blade to ensure that the alert gets closed (you may need to wait 5 seconds and refresh again to have the alert show as closed)<o:p></o:p></li></ol><p class=MsoListParagraph><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>

"@


### TYPE 4 -- Anonymous IP Email

$t4 = 'corad@octanner.com,infosec@octanner.com'

$s4 = "RISK ALERT: Anonymous IP Address"

$b4 = @"
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:w="urn:schemas-microsoft-com:office:word" xmlns:m="http://schemas.microsoft.com/office/2004/12/omml" xmlns="http://www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii"><meta name=Generator content="Microsoft Word 15 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]--></head><body lang=EN-US link="#0563C1" vlink="#954F72"><div class=WordSection1><p class=MsoNormal>Our Azure AD tenant reporting has triggered on an Login in from an Anonymous IP Address Alert for <b>$($event.userDisplayName)</b>. <o:p></o:p></p><p class=MsoNormal>Please put in an ISSD ticket following the &nbsp;ISSD-Process article:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>https://confluence.octanner.com/confluence/display/SDKB/ISSD+-Process+-+Login++from+an+Anonymous+IP+Address<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>Alert Information:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>User name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.userDisplayName)</b><o:p></o:p></p><p class=MsoNormal>Email address:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.userPrincipalName)</b><o:p></o:p></p><p class=MsoNormal>IP Address: &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>$($event.ipAddress)</b><o:p></o:p></p><p class=MsoNormal>Location:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>$($event.location.city + " " + $event.location.state)</b><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>CORAD Action Required:<o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal>You need to login Azure AD Portal with the link below: <o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><p class=MsoNormal><a href="https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017">https://aad.portal.azure.com/?reAuth=true#dashboard/private/eb3f0c34-8ecf-418e-9a90-43868baa4017</a><o:p></o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p><ol style='margin-top:0in' start=1 type=1><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Azure Active Directory blade from the left pane.<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Under Security click on Risky sign-ins<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Risk Type Event associated with this alert<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click the Context Menu for the User that is reported (the three dots next to the Status column &#8230;)<o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Resolve to Close this alert so that we do not get repeat email alerts. <o:p></o:p></li><li class=MsoListParagraph style='margin-left:0in;mso-list:l0 level1 lfo1'>Click Refresh within the Risk Event blade to ensure that the alert gets closed (you may need to wait 5 seconds and refresh again to have the alert show as closed)<o:p></o:p></li></ol><p class=MsoListParagraph><o:p>&nbsp;</o:p></p><p class=MsoNormal><o:p>&nbsp;</o:p></p></div></body></html>

"@



<#=====================================================================

        Send the Emails

======================================================================#>

$From = "ISHelpdesk.NoReply@octanner.com"

switch ($Type)
{
    ("T1"){$To = $t1; $Subject = $s1; $Body = $b1}
    ("T2"){$To = $t2; $Subject = $s2; $Body = $b2}
    ("T3"){$To = $t3; $Subject = $s3; $Body = $b3}
    ("T4"){$To = $t4; $Subject = $s4; $Body = $b4}
}

$mail = New-Object System.Net.Mail.MailMessage($From,$To)
$mail.Subject = $Subject
$mail.isbodyhtml = $true
$mail.Body = $Body

$smtp = New-Object System.Net.Mail.SmtpClient("smtp.octanner.com")
$smtp.Send($mail)

<#

if ($Type -eq "T1")
{
    $To = "chris.brown@octanner.com"
    $Subject = $MSubject
    $Body = $MBody


    $mail = New-Object System.Net.Mail.MailMessage($From,$To)
    $mail.Subject = $Subject
    $mail.isbodyhtml = $true
    $mail.Body = $Body

    $smtp = New-Object System.Net.Mail.SmtpClient("smtp.octanner.com")
    $smtp.Send($mail)
}

#>