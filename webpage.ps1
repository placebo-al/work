
$header = @"
<style>

    h1 {

        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;

    } 
</style>

"@

# Command to get the actual computer name
$ComputerName = "<h1>Computer Name: $env:computername</h1>"

# This command gets the OS info
$OSInfo = Get-CimInstance -class Win32_Operatingsystem | 
ConvertTo-Html -As List -Property Version, Caption, BuildNumber, Manufacturer -Fragment -PreContent "<h2>Operating System Information</h2>"

# This command get the processor info
$ProInfo = Get-CimInstance -ClassName Win32_Processor | 
ConvertTo-Html -As List -Property DeviceID, Name, Caption, MaxClockSpeed, SocketDesignation, Manufacturer -Fragment -PreContent "<h2>Processor Information</h2>"

# Bios Information
$BiosInfo = Get-CimInstance -ClassName Win32_BIOS | 
ConvertTo-Html -As List -Property SMBIOSBIOSVersion, Manufacturer, Name, SerialNumber -Fragment -PreContent "<h2>BIOS Information</h2>"

# Getting the drive info
$DiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | 
ConvertTo-Html -Property DeviceID, DriveType, ProviderName, VolumeName, Size, FreeSpace -Fragment -PreContent "<h2>Disk Information</h2>"

# Getting information about the top 10 services
$ServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10 | 
ConvertTo-Html -Property Name, DisplayName, State -Fragment -PreContent "<h2>Services Information</h2>"

# Combine all the info together for a report
$Report = ConvertTo-Html -Body "$ComputerName $OSInfo $ProInfo $BiosInfo $DiscInfo $ServicesInfo" -Title "Computer Information Report" -PostContent "<p>Creation Date: $(Get-Date)<p>"

# Generate the report
$Report | Out-File c:\users\watsona\Desktop\file.html
