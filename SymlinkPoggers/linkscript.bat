@echo off

set BS_FOLDER="E:\SteamLibrary\steamapps\common\Beat Saber"

net session >nul 2>&1
if %errorLevel% == 0 (
	CALL :rm_and_link "Beat Saber_Data\CustomLevels","E:\BS_STUFF\Songs"
	CALL :rm_and_link "UserData\ScoreSaber\Replays","E:\BS_STUFF\Replays"
	:: You can add more entries like the above here for other folders you want to link
) else (
  echo Admin required
)

pause > nul

:rm_and_link
	set gamepath="%BS_FOLDER:"=%\%~1"

	:: If there already is a link in that place, or an empty folder (Links turn into empty folders when copying the base folder), delete it
	rmdir %gamepath%
	if %errorlevel% == 0 (
		mklink /J %gamepath% "%~2"
	) else (
		echo "Couldnt link %gamepath% - A folder at that destination exists which is not empty"
		exit /b %errorlevel%
	)