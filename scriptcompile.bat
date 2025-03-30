@echo off
setlocal enabledelayedexpansion

:: Create the script file in a permanent location
set "SCRIPT_DIR=%USERPROFILE%\Scripts"
set "SCRIPT_PATH=%SCRIPT_DIR%\scriptcompile.bat"

:: Create the Scripts directory if it doesn't exist
if not exist "%SCRIPT_DIR%" mkdir "%SCRIPT_DIR%"

:: Create the scriptcompile.bat script
echo @echo off > "%SCRIPT_PATH%"
echo setlocal enabledelayedexpansion >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Set variables >> "%SCRIPT_PATH%"
echo set "OUTPUT_FILE=%%CD%%\script_compilation.txt" >> "%SCRIPT_PATH%"
echo set "START_DIR=%%CD%%" >> "%SCRIPT_PATH%"
echo set "FILE_EXTENSIONS=*.bat *.cmd *.ps1 *.vbs *.js *.py *.sh *.pl *.php *.rb *.sql *.cs *.java *.cpp *.c *.h *.hpp" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Allow user to specify a different directory >> "%SCRIPT_PATH%"
echo if not "%%~1"=="" ( >> "%SCRIPT_PATH%"
echo     set "START_DIR=%%~1" >> "%SCRIPT_PATH%"
echo     set "OUTPUT_FILE=%%START_DIR%%\script_compilation.txt" >> "%SCRIPT_PATH%"
echo ) >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Ensure directory path ends with a backslash >> "%SCRIPT_PATH%"
echo if not "^!START_DIR:~-1^!"=="\" set "START_DIR=^!START_DIR^!\" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Allow user to specify output file >> "%SCRIPT_PATH%"
echo if not "%%~2"=="" ( >> "%SCRIPT_PATH%"
echo     set "OUTPUT_FILE=%%~2" >> "%SCRIPT_PATH%"
echo ) >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Allow user to specify file extensions >> "%SCRIPT_PATH%"
echo if not "%%~3"=="" ( >> "%SCRIPT_PATH%"
echo     set "FILE_EXTENSIONS=%%~3" >> "%SCRIPT_PATH%"
echo ) >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo echo Script Compilation Tool >> "%SCRIPT_PATH%"
echo echo ====================== >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo echo Scanning directory: ^!START_DIR^! >> "%SCRIPT_PATH%"
echo echo Output will be saved to: ^!OUTPUT_FILE^! >> "%SCRIPT_PATH%"
echo echo Looking for file types: ^!FILE_EXTENSIONS^! >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Create the output file with a header >> "%SCRIPT_PATH%"
echo echo Script Compilation created on %%date%% at %%time%% ^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo Source directory: ^!START_DIR^! ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo ================================================================= ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Initialize counter >> "%SCRIPT_PATH%"
echo set "FileCount=0" >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo :: Loop through each file extension >> "%SCRIPT_PATH%"
echo for %%e in (^!FILE_EXTENSIONS^!) do ( >> "%SCRIPT_PATH%"
echo     for /r "^!START_DIR^!" %%f in (%%e) do ( >> "%SCRIPT_PATH%"
echo         set /a "FileCount+=1" >> "%SCRIPT_PATH%"
echo         echo Processing: %%f >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo         echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo ----------------------------------------------------------------- ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo FILE: %%~nxf ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo PATH: %%~dpf ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo SIZE: %%~zf bytes ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo LAST MODIFIED: %%~tf ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo ----------------------------------------------------------------- ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         type "%%f" ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo         echo. ^>^> "^!OUTPUT_FILE^!" >> "%SCRIPT_PATH%"
echo     ) >> "%SCRIPT_PATH%"
echo ) >> "%SCRIPT_PATH%"
echo. >> "%SCRIPT_PATH%"
echo echo. >> "%SCRIPT_PATH%"
echo echo Compilation complete! >> "%SCRIPT_PATH%"
echo echo ^!FileCount^! files have been compiled into: >> "%SCRIPT_PATH%"
echo echo ^!OUTPUT_FILE^! >> "%SCRIPT_PATH%"

:: Add the script directory to the user's PATH environment variable if not already there
for /f "tokens=3*" %%p in ('reg query HKCU\Environment /v PATH ^| findstr /i path') do set "CURRENT_PATH=%%p %%q"

:: Check if Scripts directory is already in PATH
echo %CURRENT_PATH% | findstr /C:"%SCRIPT_DIR%" > nul
if errorlevel 1 (
    :: Add Scripts directory to PATH
    setx PATH "%CURRENT_PATH%;%SCRIPT_DIR%"
    echo Added %SCRIPT_DIR% to your PATH environment variable.
    echo You will need to restart any open command prompts for the changes to take effect.
) else (
    echo Your Scripts directory is already in your PATH.
)

echo.
echo The 'scriptcompile' command has been installed!
echo.
echo Usage:
echo   scriptcompile                               - Compile scripts from current directory
echo   scriptcompile C:\path                       - Compile scripts from specified directory
echo   scriptcompile C:\path output.txt            - Specify output filename
echo   scriptcompile C:\path output.txt "*.js *.py" - Specify file types to include
echo.
echo Default file types: %FILE_EXTENSIONS%
echo.
echo Press any key to exit...
pause > nul