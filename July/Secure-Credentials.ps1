

break  ## Prevent Accidental Run of Full Script


<#=====================================================================

        Generate 256 Bit AES Encryption Key

======================================================================#>


$KeyPath = ".\AES-Encryption.key"

$Key = New-Object Byte[] 32
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($Key)
$Key | Out-File $KeyPath


<#=====================================================================

        Export Credentials

======================================================================#>


$CredsPath = ".\Name-of-File.xml"  ## be sure to update the "Name-of-File.xml" at the end. 
$KeyPath = ".\AES-Encryption.key"

$Key = Get-Content $KeyPath
$Creds = Get-Credential
$Creds = $Creds | Select-Object *
$creds.Password = $Creds.Password | ConvertFrom-SecureString -Key $Key
$Creds | Export-Clixml $CredsPath


<#=====================================================================

        Import Credentials

======================================================================#>


$CredsPath = ".\Name-of-File.xml"  ## be sure to update the "Name-of-File.xml" at the end. 
$KeyPath = ".\AES-Encryption.key"

$Key = Get-Content $KeyPath
$Creds = Import-Clixml $CredsPath
$Creds.Password = $Creds.Password | ConvertTo-SecureString -Key $Key

$AdminCredentials = New-Object -TypeName System.Management.Automation.PSCredential($Creds.UserName,$Creds.Password)


<#=====================================================================

        Example Usage After Import

======================================================================#>


Restart-Computer -ComputerName "Test-VM-01" -Credential $AdminCredentials -Force  ## Used with the $AdminCredentials variable. 