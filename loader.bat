@echo off
echo.
echo Starting DS-DOS...
if not exist system\dsdos.bat goto fail
if not exist system\system.inf goto sysfail
md C:\Tempdos
copy dsdos.bat c:\Tempdos >nul
copy system.inf c:\Tempdos >nul
del C:\Tempdos /s/q >nul
rd C:\Tempdos
timeout /t 5 /nobreak >nul
cls
cd system
call dsdos.bat
exit

:fail
echo System file is missing or corrupt. Load cannot continue.
pause >nul
exit

:sysfail
echo system.inf is missing or corrupt. Settings cannot loaded.
pause >nul
exit