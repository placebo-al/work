# Servername that can be used, but shouldn't need to be
# $Server = srv-sccm01

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
# To check
# To test, run the command, after you should see the actions in the c:\Windows\CCM\Logs\WUAHandler.log

# Alternate method calling the servername, shouldn't be required
# Invoke-WMIMethod -ComputerName $Server -Namespace root\ccm -Class SMS_CLIENT -Name TriggerSchedule "{$t}"

# For the bat file
# WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000121}" /NOINTERACTIVE
