# Followed from the following site: https://adamtheautomator.com/html-report/
$header = @"
<style>

    h1 {
        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 28px;
    } 

    h2 {
        font-family: Arial, Helvetica, sans-serif;
        color: #000099;
        font-size: 16px;
    }

   table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }

    #CreationDate {
        font-family: Arial, Helvetica, sans-serif;
        color: #e68a00;
        font-size: 12px;
    }
    .RunningStatus {
        color: #008000;
    }
    
    .StopStatus {
        color: #ff0000;
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
$BiosInfo = $BiosInfo -replace 'SMBIOSBIOSVersion', 'Bios Version'

# Getting the drive info
$DiscInfo = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" | 
ConvertTo-Html -Property DeviceID, DriveType, ProviderName, VolumeName, Size, FreeSpace -Fragment -PreContent "<h2>Disk Information</h2>"

# Getting information about the top 10 services
$ServicesInfo = Get-CimInstance -ClassName Win32_Service | Select-Object -First 10 | 
ConvertTo-Html -Property Name, DisplayName, State -Fragment -PreContent "<h2>Services Information</h2>"
$ServicesInfo = $ServicesInfo -replace '<td>Running</td>','<td class="RunningStatus">Running</td>' 
$ServicesInfo = $ServicesInfo -replace '<td>Stopped</td>','<td class="StopStatus">Stopped</td>'

# Combine all the info together for a report
$Params = @{
    Head = $header
    Title = "Computer Information Report"
    Body = "$ComputerName $OSInfo $ProInfo $BiosInfo $DiscInfo $ServicesInfo"
    PostContent = "<p id='CreationDate'>Creation Date: $(Get-Date)<p>"
}
$Report = ConvertTo-Html @Params
 

# Generate the report
$Report | Out-File c:\users\watsona\Desktop\file.html
