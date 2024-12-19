@ECHO OFF

@ECHO OFF
REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:menuLOOP
echo.
echo.======================= Menu ==================================
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.  %%B  %%C
set choice=
echo.&set /p choice=Make a choice or hit ENTER to quit: ||GOTO:EOF
echo.&call:menu_%choice%
GOTO:menuLOOP

::-----------------------------------------------------------
:: menu functions follow below here
::-----------------------------------------------------------

:menu_1   Have some fun
    echo.Have some fun by adding some more code right here
GOTO:EOF

:menu_2   List all installed printers
    wmic printer get name
GOTO:EOF

:menu_3   Tail log file

    setlocal

    set "filename=your_file.txt"
    set /a linecount=0

    REM Count the total number of lines in the file
    for /f "usebackq" %%A in (`find /c /v "" ^< %filename%`) do set linecount=%%A

    REM Offset to skip the initial lines
    set /a skipcount=linecount-10

    REM Display the last 10 lines
    for /f "usebackq skip=%skipcount% delims=" %%A in (%filename%) do echo %%A

    endlocal
    pause

GOTO:EOF

:menu_4   Force update DeviceIntegrator

setlocal

REM Stop the service
echo Stopping the DeviceIntegrator service...
net stop deviceIntegrator
if %ERRORLEVEL% neq 0 (
    echo Failed to stop the service. Exiting script.
    exit /b 1
)

REM Run the update command
set "exePath=C:\Program Files\PerfectGym\DeviceIntegrator\deviceintegrator.exe"
if exist "%exePath%" (
    echo Running the update...
    "%exePath%" noservice update
    if %ERRORLEVEL% neq 0 (
        echo Update failed. Exiting script.
        exit /b 1
    )
) else (
    echo The executable was not found at %exePath%. Exiting script.
    exit /b 1
)

REM Start the service
echo Starting the DeviceIntegrator service...
net start deviceIntegrator
if %ERRORLEVEL% neq 0 (
    echo Failed to start the service. Exiting script.
    exit /b 1
)

echo The DeviceIntegrator service was updated and restarted successfully.
endlocal

GOTO:EOF

:menu_D   Download DeviceIntegrator

    curl.exe -L -o DeviceIntegrator.msi https://download.perfectgymcdn.com/di/DeviceIntegrator.Installer.2.5.msi
    REM Ensure the file is the expected type
    REM Check the file extension (if needed, ensure curl saves it correctly as .msi)
    set "expectedExtension=.msi"
    for %%A in ("DeviceIntegrator.exe") do (
        if /I not "%%~xA"=="%expectedExtension%" (
            echo Unexpected file type downloaded. Aborting.
            exit /b 1
        )
    )

GOTO:EOF

:menu_C   Clear Screen
    cls
GOTO:EOF



@REM reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" >nul 2>&1
@REM if %ERRORLEVEL% EQU 0 (
@REM     echo I found it
@REM ) else (
@REM     echo It doesn't exist
@REM )


@REM REM Define registry keys to check
@REM set keys="HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT"
@REM set keys="%keys% HKEY_LOCAL_MACHINE\SOFTWARE\SomeOtherKey"
@REM set keys="%keys% HKEY_CURRENT_USER\Software\AnotherKey"

@REM REM Loop through each registry key
@REM for %%k in (%keys%) do (
@REM     echo Checking %%k...
@REM     reg query "%%k" >nul 2>&1
@REM     if %ERRORLEVEL% EQU 0 (
@REM         echo Found %%k
@REM     ) else (
@REM         echo %%k does not exist
@REM     )
@REM )


@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" /v AUTO_INTERNAL_DIAL /t REG_DWORD /d 1
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" /v AUTODISMISS /t REG_DWORD /d 1
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" /v FOCUS_TYPE /t REG_DWORD /d 2
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" /v IP_INTERFACE_PORT /t REG_DWORD /d 8080
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\CullenSoftwareDesign\EFTCLIENT\CLIENT" /v IP_INTERFACE_SOCKET_REJECT /t REG_DWORD /d 1
