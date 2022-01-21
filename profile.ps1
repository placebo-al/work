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
