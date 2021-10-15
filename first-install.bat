@echo on
CLS
REM This is my initial install script covering my checklist

TITLE My initial install script

REM Need to start this early
cd\
c:
START /B gpupdate /force

@REM REM Still not sure if this is working
START UsoClient ScanInstallWait 

@REM REM Time to add the certificates
START /B certmgr.msc

@REM REM Save this as the homepage
START /B "" https://intranet.yarracity.vic.gov.au

@REM REM See if these work
WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000121}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000003}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000010}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000001}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000021}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000022}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000002}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000031}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000108}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000113}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000111}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000026}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000027}" /NOINTERACTIVE
@REM WMIC /namespace:\\root\ccm path sms_client CALL TriggerSchedule "{00000000-0000-0000-0000-000000000032}" /NOINTERACTIVE

@REM netsh interface teredo set state disabled
@REM netsh interface ipv6 6to4 set state state=disabled undoonstop=disabled
@REM netsh interface ipv6 isatap set state state=disabled


ECHO "The program has completed"
EXIT
