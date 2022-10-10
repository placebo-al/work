
# Command to get the actual computer name
$ComputerName = "<h1>Computer Name: $env:computername</h1>"
# This command gets the OS info
$OSInfo = Get-CimInstance -class Win32_Operatingsystem | ConvertTo-Html -Property Version, Caption, BuildNumber, Manufacturer -Fragment
# This command get the processor info
$ProInfo = Get-CimInstance -ClassName Win32_Processor | ConvertTo-Html -Property DeviceID, Name, Caption, MaxClockSpeed, SocketDesignation, Manufacturer -Fragment
# Bios Information
$BiosInfo = Get-CimInstance -ClassName Win32_BIOS | ConvertTo-Html -Property SMBIOSBIOSVersion, Manufacturer, Name, SerialNumber -Fragment
# Getting the drive info
$DiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | ConvertTo-Html -Property DeviceID, DriveType, ProviderName, VolumeName, Size, FreeSpace -Fragment
# Getting information about the top 10 services
$ServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10 | ConvertTo-Html -Property Name, DisplayName, State -Fragment
# Combine all the info together for a report
$Report = ConvertTo-Html -Body "$ComputerName $OSInfo $ProInfo $BiosInfo $DiscInfo $ServicesInfo"
# Generate the report
$Report | Out-File c:\users\watsona\Desktop\file.html
