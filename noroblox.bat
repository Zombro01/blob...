@echo off
SET "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/noroblox.bat"
SET "tempFile=%TEMP%\updated_noroblox.bat"

echo Updating batch file from %url%...
:: Download the latest version from GitHub using certutil
certutil -urlcache -split -f "%url%" "%tempFile%" >nul 2>&1

:: Check if the file was downloaded successfully
IF EXIST "%tempFile%" (
    echo Download successful.
    echo Replacing current batch file with the updated one...
    copy /y "%tempFile%" "%~f0" >nul
    echo Update complete.
    :: Clean up temporary file
    del "%tempFile%" >nul
) ELSE (
    echo Failed to download the update. Please check your internet connection.
)
echo done
pause
