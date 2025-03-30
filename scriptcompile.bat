@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo ScriptCompile Command - Standalone Version
echo ===================================================
echo.

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrator privileges.
    echo Please right-click and select "Run as administrator".
    echo.
    pause
    exit /b
)

:: Create the Scripts directory in user profile
set "SCRIPT_DIR=%USERPROFILE%\Scripts"
if not exist "%SCRIPT_DIR%" (
    echo Creating Scripts directory...
    mkdir "%SCRIPT_DIR%"
)

:: Create the scriptcompile.bat file as a completely standalone solution
set "SCRIPT_PATH=%SCRIPT_DIR%\scriptcompile.bat"
echo Creating scriptcompile command...

(
echo @echo off
echo setlocal enabledelayedexpansion
echo.
echo :: Set variables
echo set "OUTPUT_FILE=%%CD%%\script_compilation.txt"
echo set "START_DIR=%%CD%%"
echo.
echo :: Allow user to specify a different directory
echo if not "%%~1"=="" ^(
echo     set "START_DIR=%%~1"
echo     set "OUTPUT_FILE=%%START_DIR%%\script_compilation.txt"
echo ^)
echo.
echo :: Ensure directory path ends with a backslash
echo if not "%%START_DIR:~-1%%"=="\" set "START_DIR=%%START_DIR%%\"
echo.
echo :: Allow user to specify output file
echo if not "%%~2"=="" ^(
echo     set "OUTPUT_FILE=%%~2"
echo ^)
echo.
echo :: Create the output file with a header
echo echo Script Compilation created on %%date%% at %%time%% ^> "%%OUTPUT_FILE%%"
echo echo Source directory: %%START_DIR%% ^>^> "%%OUTPUT_FILE%%"
echo echo ================================================================= ^>^> "%%OUTPUT_FILE%%"
echo echo. ^>^> "%%OUTPUT_FILE%%"
echo.
echo :: Initialize file counter
echo set "FileCount=0"
echo set "TotalFiles=0"
echo.
echo echo Script Compilation Tool
echo echo ======================
echo echo.
echo echo Scanning directory: %%START_DIR%%
echo echo Output will be saved to: %%OUTPUT_FILE%%
echo echo.
echo.
echo :: Process Python files
echo echo Searching for .py files...
echo.
echo for /r "%%START_DIR%%" %%%%F in ^(*.py^) do ^(
echo     if exist "%%%%F" ^(
echo         set /a FileCount+=1
echo         set /a TotalFiles+=1
echo         echo [!FileCount!] Processing: %%%%F
echo.
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo FILE: %%%%~nxF ^>^> "%%OUTPUT_FILE%%"
echo         echo PATH: %%%%~dpF ^>^> "%%OUTPUT_FILE%%"
echo         echo SIZE: %%%%~zF bytes ^>^> "%%OUTPUT_FILE%%"
echo         echo LAST MODIFIED: %%%%~tF ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         type "%%%%F" ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo     ^)
echo ^)
echo.
echo :: Process JavaScript files
echo echo Searching for .js files...
echo set "FileCount=0"
echo.
echo for /r "%%START_DIR%%" %%%%F in ^(*.js^) do ^(
echo     if exist "%%%%F" ^(
echo         set /a FileCount+=1
echo         set /a TotalFiles+=1
echo         echo [!FileCount!] Processing: %%%%F
echo.
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo FILE: %%%%~nxF ^>^> "%%OUTPUT_FILE%%"
echo         echo PATH: %%%%~dpF ^>^> "%%OUTPUT_FILE%%"
echo         echo SIZE: %%%%~zF bytes ^>^> "%%OUTPUT_FILE%%"
echo         echo LAST MODIFIED: %%%%~tF ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         type "%%%%F" ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo     ^)
echo ^)
echo.
echo :: Process batch files
echo echo Searching for .bat and .cmd files...
echo set "FileCount=0"
echo.
echo for /r "%%START_DIR%%" %%%%F in ^(*.bat *.cmd^) do ^(
echo     if exist "%%%%F" ^(
echo         set /a FileCount+=1
echo         set /a TotalFiles+=1
echo         echo [!FileCount!] Processing: %%%%F
echo.
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo FILE: %%%%~nxF ^>^> "%%OUTPUT_FILE%%"
echo         echo PATH: %%%%~dpF ^>^> "%%OUTPUT_FILE%%"
echo         echo SIZE: %%%%~zF bytes ^>^> "%%OUTPUT_FILE%%"
echo         echo LAST MODIFIED: %%%%~tF ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         type "%%%%F" ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo     ^)
echo ^)
echo.
echo :: Process C/C++ files
echo echo Searching for .c, .cpp, .h and .hpp files...
echo set "FileCount=0"
echo.
echo for /r "%%START_DIR%%" %%%%F in ^(*.c *.cpp *.h *.hpp^) do ^(
echo     if exist "%%%%F" ^(
echo         set /a FileCount+=1
echo         set /a TotalFiles+=1
echo         echo [!FileCount!] Processing: %%%%F
echo.
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo FILE: %%%%~nxF ^>^> "%%OUTPUT_FILE%%"
echo         echo PATH: %%%%~dpF ^>^> "%%OUTPUT_FILE%%"
echo         echo SIZE: %%%%~zF bytes ^>^> "%%OUTPUT_FILE%%"
echo         echo LAST MODIFIED: %%%%~tF ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         type "%%%%F" ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo     ^)
echo ^)
echo.
echo :: Process other script files
echo echo Searching for other script file types...
echo set "FileCount=0"
echo.
echo for /r "%%START_DIR%%" %%%%F in ^(*.ps1 *.vbs *.sh *.pl *.php *.rb *.sql *.cs *.java *.tsx *.jsx *.ts^) do ^(
echo     if exist "%%%%F" ^(
echo         set /a FileCount+=1
echo         set /a TotalFiles+=1
echo         echo [!FileCount!] Processing: %%%%F
echo.
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo FILE: %%%%~nxF ^>^> "%%OUTPUT_FILE%%"
echo         echo PATH: %%%%~dpF ^>^> "%%OUTPUT_FILE%%"
echo         echo SIZE: %%%%~zF bytes ^>^> "%%OUTPUT_FILE%%"
echo         echo LAST MODIFIED: %%%%~tF ^>^> "%%OUTPUT_FILE%%"
echo         echo ----------------------------------------------------------------- ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         type "%%%%F" ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo         echo. ^>^> "%%OUTPUT_FILE%%"
echo     ^)
echo ^)
echo.
echo echo.
echo echo Compilation complete!
echo echo !TotalFiles! files have been compiled into:
echo echo %%OUTPUT_FILE%%
) > "%SCRIPT_PATH%"

:: Add the Scripts directory to PATH if not already there
echo Checking PATH environment variable...
set "PATH_UPDATED=0"

:: Get current user PATH
for /f "tokens=2*" %%A in ('reg query HKCU\Environment /v PATH 2^>nul ^| find "PATH"') do set "USER_PATH=%%B"

:: Check if Scripts directory is already in PATH
if defined USER_PATH (
    echo %USER_PATH% | findstr /C:"%SCRIPT_DIR%" >nul
    if errorlevel 1 (
        :: Not found in user PATH, add it
        setx PATH "%USER_PATH%;%SCRIPT_DIR%"
        set "PATH_UPDATED=1"
    ) else (
        echo Scripts directory already in PATH.
    )
) else (
    :: No user PATH exists, create it
    setx PATH "%SCRIPT_DIR%"
    set "PATH_UPDATED=1"
)

echo.
echo ===================================================
echo Installation Complete!
echo ===================================================
echo.
echo The scriptcompile command has been installed!
echo.

if "%PATH_UPDATED%"=="1" (
    echo Your PATH has been updated. You need to restart any open 
    echo command prompts for the changes to take effect.
    echo.
)

echo Usage examples:
echo.
echo   scriptcompile                 - Compile scripts from current directory
echo   scriptcompile C:\path         - Compile scripts from specified directory
echo   scriptcompile C:\path output.txt - Specify output filename
echo.
echo Press any key to exit...
pause > nul