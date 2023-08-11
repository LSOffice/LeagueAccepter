@echo off
set "batchFilePath=%~dp0init.py"

REM Check if the registry entry already exists
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "LAAutoLaunch" | find /i "LAAutoLaunch" >nul
if %errorlevel% equ 0 (
    echo Registry entry already exists. Skipping.
) else (
    REM Add the registry entry
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "LAAutoLaunch" /t REG_SZ /d "python.exe \"%batchFilePath%\"" /f
    echo Registry entry added successfully.
)
goto :DOES_PYTHON_EXIST

:DOES_PYTHON_EXIST
python -V | find /v "Python" >NUL 2>NUL && (goto :PYTHON_DOES_NOT_EXIST)
python -V | find "Python"    >NUL 2>NUL && (goto :PYTHON_DOES_EXIST)
goto :EOF

:PYTHON_DOES_NOT_EXIST
echo Python is not installed on your system.
python3
goto :EOF

:PYTHON_DOES_EXIST
pip install -r requirements.txt
python3 leagueaccepter.py
goto :EOF

