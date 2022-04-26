@REM the dp0 is to point to the current directory and path
@REM This code needs a copy of the Get-WindowsAutoPilotInfo.ps1 file in the same folder and drive
PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command %~dp0\Get-WindowsAutoPilotInfo.ps1 -OutputFile %~dp0\computers.csv -append