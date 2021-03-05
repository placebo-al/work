<#
     .Synopsis
     Initial install helper script, needs to be run in admin shell
     .DESCRIPTION
     Initial install helper script, needs to be run in admin shell, this includes:
     Run the Group Policy update
     Open the certificate manager
     Disable IPV6 for the Wifi connection
     Write P-drive.bat to the desktop
     Open Team Viewer to be installed
     Open the default browser to our homepage, still has to be saved as the start page
     Force update SCCM
     .EXAMPLE
     Example of how to use this cmdlet
     .\first-install.ps1

     .NOTES
     Author: Alan Watson
     Contact: placebo_al@hotmail.com
#>

function disable-ipv6 {
    # Disable IPV6 for the Wifi connection
    Write-output "Disabling IPV6 now"
    Disable-NetAdapterBinding -Name "WiFi" -ComponentID ms_tcpip6
    # Disable-NetAdapterBinding -Name "Mobile*" -ComponentID ms_tcpip6
}

function cert-mgr {
    certmgr.msc
}

function gp-update {
    gpupdate /Force
}

function write-bdrive {
    # Write B-drive.bat to the desktop
    Set-Content -Path 'c:\Users\Public\Desktop' -Value @"
@ECHO OFF
NET USE B: /DELETE
NET USE B:
"@
}

function team-viewer {
    # Open Team Viewer to be installed
    Invoke-Item ''
    Invoke-Item ''
}

function set-homepage {
    # Open the default browser to our homepage, still has to be saved as the start page
    Start-Process "www.google.com"
}

function update-sccm {
    # Force update SCCM 
    $trigger = @(
    '00000000-0000-0000-0000-000000000121',    # Application Deployment Evaluation Cycle
    '00000000-0000-0000-0000-000000000003',    # Discovery Data Collection Cycle
    '00000000-0000-0000-0000-000000000010',    # File Collection Cycle
    '00000000-0000-0000-0000-000000000001',    # Hardware Inventory Cycle
    '00000000-0000-0000-0000-000000000021',    # Machine Policy Retrieval Cycle
    '00000000-0000-0000-0000-000000000022',    # Machine Policy Evaluation Cycle
    '00000000-0000-0000-0000-000000000002',    # Software Inventory Cycle
    '00000000-0000-0000-0000-000000000031',    # Software Metering Usage Report Cycle
    '00000000-0000-0000-0000-000000000114',    # Software Update Deployment Evaluation Cycle
    '00000000-0000-0000-0000-000000000113',    # Software Update Scan Cycle
    '00000000-0000-0000-0000-000000000111',    # State Message Refresh
    '00000000-0000-0000-0000-000000000026',    # User Policy Retrieval Cycle
    '00000000-0000-0000-0000-000000000027',    # User Policy Evaluation Cycle
    '00000000-0000-0000-0000-000000000032'     # Windows Installers Source List Update Cycle
    )
    foreach ($t in $trigger)
    {
        Invoke-WMIMethod -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{$t}"
    }
}

function Show-Menu
{
     param (
           [string]$Title = 'My Menu'
     )
     clear-host
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' to disable IPV6."
     Write-Host "2: Press '2' to open Certificate Manager."
     Write-Host "3: Press '3' write B-drive.bat to the desktop."
     Write-Host "4: Press '4' to start the Team Viewer installer."
     Write-Host "5: Press '5' to open the home page, remember to save it to the start page."
     Write-Host "6: Press '6' to update SCCM."
     Write-Host "7: Press '7' to run group policy update."
     Write-Host "Q: Press 'Q' to quit."
}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                clear-host
                disable-ipv6
           } '2' {
                clear-host
                cert-mgr
           } '3' {
                clear-host
                write-bdrive
           } '4' {
                clear-host
                team-viewer 
           } '5' {
                clear-host
                set-homepage
           } '6' {
                clear-host 
                update-sccm
           } '7' {
                clear-host
                gp-update
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')
