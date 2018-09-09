@echo off
type msg.dll
echo CDROM letter
echo Drive D: - CDROM
:cmd
set /p comm="C:\>"
if %comm%==help goto help
if %comm%==ver goto ver
if %comm%==edit (
start /wait prog\edit.bat
goto cmd
)
if %comm%==calculator (
start /wait prog\calc.bat
goto cmd
)
if %comm%==game (
start /wait prog\game.bat
goto cmd
)
if %comm%==cls (
cls
goto cmd
)
if %comm%==sexplorer (
start /wait prog\sexplorer.bat
goto cmd
)
if %comm%==shutdown goto shutdown
goto other

:help
echo Commands: help, ver, edit, calculator, cls, shutdown, game, sexplorer
echo This OS is new line of MS-DOS.
echo New programs, own BIOS and drivers.
echo All this in new DS-DOS 1.0
pause
goto cmd

:ver
echo DS-DOS v.1.0
echo (C) DaniMat Corp.
goto cmd

:shutdown
echo This will shutdown your computer
choice /c:SRC /m:"(S)hutdown, (R)estart or (C)ancel"
if errorlevel 3 goto cmd
if errorlevel 2 (
echo Closing tasks...
timeout /t 3 /nobreak >nul
echo Restarting...
timeout /t 5 /nobreak >nul
cls
cd..
call start.bat
)
echo Closing tasks...
timeout /t 3 /nobreak >nul
echo Shutting down...
timeout /t 5 /nobreak >nul
exit

:other
start /wait %comm%
goto cmd