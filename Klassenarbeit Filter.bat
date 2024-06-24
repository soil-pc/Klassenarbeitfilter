@echo off
title Klassenarbeit Filter
setlocal enabledelayedexpansion

REM Input Filepath
set /p "input_path=Enter a Filepath: "

REM Desktop Path for result.txt
set "desktop_path=%USERPROFILE%\Desktop\result.txt"

REM Clear the result file if it already exists
if exist "%desktop_path%" del "%desktop_path%"

REM Initialize counter
set "file_count=0"

REM Iterate through the files in the input directory
for /r "%input_path%" %%f in (*) do (
    REM Check the file extension
    set "filename=%%f"
    set "extension=%%~xf"

    if not "!extension!"==".exe" if not "!extension!"==".bat" if not "!extension!"==".msi" (
        REM Exclude directories
        if not exist "%%f\" (
            echo %%f >> "%desktop_path%"
            REM Increment file count
            set /a "file_count+=1"
        )
    )
)
cls
REM Write file count to result.txt
echo %file_count% >> "%desktop_path%" Files Found!

echo result saved in %desktop_path% in Desktop.
pause
