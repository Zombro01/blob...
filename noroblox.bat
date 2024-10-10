@echo off
SET "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/noroblox.bat"
SET "tempFile=%TEMP%\remote_noroblox.bat"

echo Downloading batch file from %url%...
:: Download the latest version from GitHub using certutil
certutil -urlcache -split -f "%url%" "%tempFile%" >nul 2>&1

:: Check if the file was downloaded successfully
IF EXIST "%tempFile%" (
    echo Download successful. Running the script...
    call "%tempFile%"
    :: Clean up the temporary file
    del "%tempFile%" >nul
) ELSE (
    echo Failed to download the script. Please check your internet connection.
)

pause
