
<#=================================================================================================

                        SS PowerShell - Remote Management Examples
                    -------------------------------------------------

    The following example scripts will demonstrate various techniques for leveraging 
    PowerShell's Remote Management capablities. The following topics will be covered:

            
            -- Basic, Cmdlet-based, remote management; which requires no WinRM or
            Firewall configuration. 

            -- True, session-based, Remote PowerShell; which DOES require proper
            WinRM and Firewall configuration.

        
    Author:  O.C. Tanner 
    Date:  September 2018               

==================================================================================================#>






<#=================================================================================================

                    SECTION 1 -- Cmdlet-based Remote Management

==================================================================================================#>


<#-------------------------------------------------------------------------------------------

 Getting Started - Find Cmdlets 

--------------------------------------------------------------------------------------------#>

## This command will display all the default Microsoft cmdlets that utilize remote management. 

    Get-Command -Module Microsoft.PowerShell.Management | Where-Object {$_.parameters.keys -contains "ComputerName" -and $_.parameters.keys -notcontains "Session"}

break ## Prevent the entire script from being run all at once.

<#-------------------------------------------------------------------------------------------

 Example 1 - Discover Remote Services

--------------------------------------------------------------------------------------------#>

## Return all services on a remote computer. 
    
    Get-Service -ComputerName localhost 


## Return all services on a remote computer that are currently running.

    Get-Service -ComputerName localhost | Where-Object {$_.Status -eq "Running"}


## Check whether the 'Print Spooler' service is running on three differemt servers.

    $Server1 = server1; $Server2 = server2; $Server3 = server3  # You'll want to put in your server names here.
    
    Get-Service -ComputerName $Server1,$Server2,$Server3 | Where-Object {$_.name -like "Spooler"} 


    
<#-------------------------------------------------------------------------------------------

 Example 2 - Remote Computer Information via WMI

--------------------------------------------------------------------------------------------#>

## List some available WMI Classes we can use to query remote computer information.

    Get-WmiObject -Namespace 'root\cimv2' -List  # There are a lot! We'll use Win32_LogicalDisk for the following examples.


## Find all Drives associated with a remote computer. Replace 127.0.0.1 with IP or hostname of remote computer. 

    Get-WmiObject -Class "Win32_LogicalDisk" -ComputerName 127.0.0.1


## Get only the C: drive information. Replace 127.0.0.1 with IP or hostname of remote computer. 

    Get-WmiObject -Class "Win32_LogicalDisk" -ComputerName 127.0.0.1 | Where-Object {$_.DeviceID -eq 'c:'}


## Another method of using WMI to get C: drive info. Store this in the $disk variable. Replace 'localhost' with hostname of remote computer.

    $disk = [wmi]"\\localhost\root\cimv2:Win32_logicalDisk.DeviceID='c:'"
    $disk
    
    # Style Points! Format Disk Space into an useful message.  

    $message = "`nDrive C: -- {0:#} GB Available `nDrive C: -- {1:#} GB Total" -f ($disk.FreeSpace/1GB),($disk.Size/1GB)
    $message 


## Bring it all together! Report C: drive info for all computers in an AD Security group.

    $ADGroupMembers = Get-ADGroupMember -Identity "Test" # This will need to be an AD group in your domain.

    foreach ($Computer in $ADGroupMembers)
    {
        $RemoteDiskInfo = Get-WmiObject -Class 'Win32_LogicalDisk' -ComputerName $Computer.name | Where-Object {$_.DeviceID -eq 'c:'}

        $Report = "`n`n      $($Computer.name) `n----------------------------  `nDrive C: -- {0:#} GB Available `nDrive C: -- {1:#} GB Total" 

        $Report -f ($RemoteDiskInfo.FreeSpace/1GB),($RemoteDiskInfo.Size/1GB)
    }



<#-------------------------------------------------------------------------------------------

 Example 3 - Windows Update/Hotfix Information

--------------------------------------------------------------------------------------------#>

## Display a list of all updates currently installed on a remote computer.

    Get-HotFix -ComputerName localhost


## Display all updates installed so far in the year 2018.

    Get-HotFix -ComputerName localhost | Where-Object {$_.InstalledOn -gt (Get-Date -Date '01/01/2018')}


## Check all computers in an AD Security Group for a specific Hotfix/Update (we'll use the RSAT as an example KB). 
    
    $ADGroupMembers = Get-ADGroupMember -Identity "Test"  # This will need to be an AD group in your domain.

    foreach ($Computer in $ADGroupMembers) 
    {
        $Check = Get-HotFix -ComputerName $Computer.name -Id KB2693643 -ErrorAction SilentlyContinue
        
        if ($?)  # The $? variable is built into PowerShell. It always stores the success or failure of the most recent command as TRUE or FALSE. 
        {
            Write-Host -ForegroundColor Green "$($Computer.name) -- SUCCESS -- Update KB2693643 installed on $(Get-Date $Check.InstalledOn -Format d)."
        }

        else
        {
            Write-Host -ForegroundColor Red "$($Computer.name) -- FAILURE -- Update KB2693643 not installed!"
        }
    }




<#=================================================================================================

                    SECTION 2 -- Session-based Remote PowerShell 

==================================================================================================#>


<#-------------------------------------------------------------------------------------------

 Example 1 - Start a session with Azure AD Connect server; run an AD/Azure syncronization.

--------------------------------------------------------------------------------------------#>

## Security! We're obfuscating the hostname of our Azure AD Connect server here.. Dont mind us! 

    $Azure = Server # Replace this with the Hostname/IP of your Azure AD Connect server. 


## Using Invoke Command -- Sent a simple script block to the remote session. 

    Invoke-Command -ComputerName $Azure -ScriptBlock {Start-ADSyncSyncCycle -PolicyType Delta}


## Using Enter-PSSession -- Once you enter, you can type commands as if you were sitting at the remote computer.

    Enter-PSSession -ComputerName $Azure 
    
  # Enter 'exit' in the remote session to close it and return to the local session. 
    



<#-------------------------------------------------------------------------------------------

 Example 2 - Start a session with a Domain Controller; create a new DNS record.

--------------------------------------------------------------------------------------------#>

## Security again! We like to be sneaky... 

    $PrimaryDC = Server # Replace this with the Hostname/IP of your Primary Domain Controller. 


## Create a PSSession to the Domain Controller. Use a fancy Invoke-Command with parameters to send data from the local session to the remote session.

    $DnsZone = 'octanner.com'
    $DnsName = 'SS-PowerShell'
    $IpAddress = '172.29.10.55'

    $Session = New-PSSession -ComputerName $PrimaryDC
 
        Invoke-Command -Session $Session -ArgumentList $DnsName,$DnsZone,$IpAddress -ScriptBlock `
        {param($n,$z,$i); Import-Module DnsClient; Add-DnsServerResourceRecordA -CreatePtr -AllowUpdateAny -Name $n -ZoneName $z -IPv4Address $i} 
        
        # Everything in the ScriptBlock is executed by the remote session.

    Remove-PSSession $Session



<#-------------------------------------------------------------------------------------------

 Example 3 - Install software on a remote computer; retrieve failure report. 

--------------------------------------------------------------------------------------------#>

## This script will install Google Chrome all remote computers

    # We'd get a list of computers here. The source can be anything. A txt file, searching the members of a security group, etc. 

<<<<<<< HEAD
    $TargetComputers = Get-Content -Path "C:\git\RemoteInstall\Computers.txt"  # You want to point this to your own txt file 
=======
    $TargetComputers = Get-Content -Path #path-to-txt-file
>>>>>>> 220086003a66cb5e7640979d1192e65fe5ab5fb3
        

## The main installation script. We'll start with a foreach loop and a test for network connectivity.. 

    foreach ($Computer in $TargetComputers)
    {
        if (Test-Connection -computername $Computers -Count 2)
        {
            try 
            {
                # If the remote computer is reachable on the network we send over the install file

                $Session = New-PSSession -ComputerName $Computer 

                Copy-Item "\\NETWORKSHARE\googlechromestandaloneenterprise64.msi" -Destination "C:\Install\" -ToSession $Session


                # This script block is then ran on the remote computer locally

                Invoke-Command -Session $Session -ScriptBlock {& cmd /c "msiexec.exe /q /i C:\Install\googlechromestandaloneenterprise64.msi" }


                # Report the successful install

                Write-Host -ForegroundColor Green "$($Computer) -- SUCCESS -- Chrome has been installed."

            }

            # We use the catch here to report back any failed connections

            catch 
            {
                Write-Host -ForegroundColor Red "$($Computer) -- FAILURE -- Unable to install Chrome..."
            }
        }
    }
