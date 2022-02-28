Set-Location $ENV:USERPROFILE

New-Alias -Name "c" -Value Clear-Host

function Good-Morning {
    $cred = Get-Credential 
    Start-Process -Credential $cred "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\Microsoft.ConfigurationManagement.exe" -WorkingDirectory "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\" -WindowStyle Minimized

    Start-Process -Credential $cred -FilePath "C:\Windows\System32\cmd.exe" -WorkingDirectory "C:\Windows\System32\" -ArgumentList "/c dsa.msc"
    
    Start-Process "C:\Program Files (x86)\Microsoft Office\root\Office16\ONENOTE.EXE" -WindowStyle Minimized

    Start-Process -File "$($env:LOCALAPPDATA)\Microsoft\Teams\Update.exe" -ArgumentList '--processStart "Teams.exe"'

    Start-Process "C:\Program Files (x86)\Microsoft Office\root\Office16\lync.exe"

    Start-Process "C:\Program Files (x86)\Microsoft Office\root\Office16\OUTLOOK.EXE"

    Start-Process "https://ictsupport.yarracity.vic.gov.au/HEAT/#1629949870611"

    Start-Process "C:\Program Files (x86)\TeamViewer\TeamViewer.exe" -WindowStyle Minimized
}

function show-printer {

    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$Printer_Id
    )

    $printer_list = Import-csv c:\users\watsona\Documents\printers.csv -delimiter '|'
    $Selected_Printer = $printer_list | Where-Object { $_.id -like $Printer_Id }
    if ($null -eq $Selected_Printer) {
        Write-Output "The $Printer_Id isn't in this file"
        break
    }

    if ($null -ne $Selected_Printer.ip) {
        Start-Process $Selected_Printer.ip    
    }
    else {
        Write-Output "This printer $Printer_Id doesn't have an ip address"
    }
    $Selected_Printer | Format-List
}
