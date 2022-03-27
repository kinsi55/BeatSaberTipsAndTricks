@echo off

set BS_FOLDER="E:\SteamLibrary\steamapps\common\Beat Saber"

net session >nul 2>&1
if %errorLevel% == 0 (
	CALL :rm_and_link "Beat Saber_Data\CustomLevels","E:\BS_STUFF\Songs"
	CALL :rm_and_link "UserData\ScoreSaber\Replays","E:\BS_STUFF\Replays"
	REM You can add more entries like the above here for other folders you want to linkYou can add more entries like the above here for other folders you want to link
) else (
  echo Admin required
)

echo Press any key to continue exit

pause > nul

:rm_and_link
	set gamepath="%BS_FOLDER:"=%\%~1"

	:: If there already is a link in that place, or an empty folder (Links turn into empty folders when copying the base folder), delete it
	rmdir %gamepath% >nul 2>&1
	if %errorlevel% == 0 (
		mklink /J %gamepath% "%~2" >nul 2>&1
	) else if %errorlevel% == 2 (
		mklink /J %gamepath% "%~2" >nul 2>&1

	) else if %errorlevel% == 145 (
		echo Couldnt link %gamepath% - A folder at that destination exists which is not empty
		exit /b %errorlevel%
	)

	if %errorlevel% == 0 (
		echo Linked "%~1" to "%~2"
	) else (
		echo Couldnt link %gamepath% - Unknown Error
		exit /b %errorlevel%
	)