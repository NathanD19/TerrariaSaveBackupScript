@REM Terraria Backup Script
@REM Windows Only
@echo off

set /A minutes=30
set /A seconds=%minutes% * 60

echo Terraria Backup Script
echo This script will back up your selected world file every %minutes% minutes

:user_input
echo:
SET /P _inputworld= Please enter a valid world name:
IF "%_inputworld%"=="" GOTO :user_input

set world_path="%UserProfile%\Documents\My Games\Terraria\Worlds\%_inputworld%.wld"

if exist %world_path%  (
    @REM file exists
    echo World Found! Starting Backup Process...
    echo:
    echo To ensure the back up is running please make sure the timeout counter is ticking down.

    if not exist "backups\%_inputworld%" md "backups\%_inputworld%"
) else (
    @REM file does not exist
    echo World file "%_inputworld%" does not exist. Please try again.
    GOTO :user_input
)

@REM Backup loop
:loop
    @REM Create DateTime
    set TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
    @REM Copy World File And Rename

    set backup_destination="backups\%_inputworld%\%_inputworld%_%TIMESTAMP%.wld"
    copy /y %world_path% %backup_destination% >nul

    @REM Create Spacing 
    echo:
    echo ---------------------------------------------------------------------------------
    echo:

    if exist %backup_destination% (
        echo World "%_inputworld%" backed up succesfully at %TIMESTAMP%
    ) else (
        echo "WARNING! World file back up failed! Please close the process and try again."
    )

    @REM for /f %%A in ('dir /a-d-s-h /b ^| find /v /c ""') do set cnt=%%A
    @REM echo File count = %cnt%
    echo:
    echo Pressing any key will create a back up of the file automatically.
    timeout /t %seconds% 
goto loop
