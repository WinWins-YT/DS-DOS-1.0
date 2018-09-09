@echo off
timeout /t 2 /nobreak >nul
if not exist vgavideo.sys goto vgafail
if not exist bios.sys goto biosfail
echo Hrenoviy BIOS v.4.0
echo (C)Hrenoten Inc.
echo Processor: Intel Pentium III 667MHz - Detected
timeout /t 2 /nobreak >nul
echo 131072KB OK
timeout /t 5 /nobreak >nul
echo Primary Master......HDD SAMSUNG 10GB
timeout /t 2 /nobreak >nul
echo Primary Slave.......CDROM TOSHIBA
timeout /t 2 /nobreak >nul
echo Secondary Master....None
timeout /t 2 /nobreak >nul
echo Secondary Slave.....None
timeout /t 5 /nobreak >nul
if not exist loader.bat (
echo LOADER is missing or corrupt.
pause >nul
exit
)
call loader.bat
exit

:vgafail
cls
pause >nul
exit

:biosfail
cls
color 22
pause >nul
exit