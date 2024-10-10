@echo off
SET "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/nrblx.txt"
SET "tempFile=%TEMP%\nrblx_commands.bat"

:: Function to add a 20-millisecond delay
:delay
ping localhost -n 1 -w 20 >nul
exit /b

echo Downloading command file from %url%...
:: Delay before downloading
call :delay
:: Download the latest version from GitHub using certutil
certutil -urlcache -split -f "%url%" "%tempFile%" >nul 2>&1

:: Delay after download
call :delay
:: Check if the file was downloaded successfully
IF EXIST "%tempFile%" (
    echo Download successful. Running the script...
    :: Delay before running the script
    call :delay
    call "%tempFile%"
    :: Clean up the temporary file
    call :delay
    del "%tempFile%" >nul
) ELSE (
    echo Failed to download the script. Please check your internet connection.
)

:: Delay before the pause at the end
call :delay
pause
