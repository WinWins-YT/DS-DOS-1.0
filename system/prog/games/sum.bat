@echo off
cls
set /a level=1
echo SUM FOR DS-DOS
echo WRITTEN BY DANILA
:Level
echo Level %level%
set /a first=1+50*%random%/32768
set /a second=1+50*%random%/32768
set /a sum=%first%+%second%
echo %first%+%second%=?
set /p answ="Enter answer: "
if %sum%==%answ% goto win
if not %sum%==%answ% goto lose

:win
echo Correct!
timeout /t 2 /nobreak >nul
set /a Level=%level%+1
goto Level

:lose
echo Incorrect :-(
timeout /t 2 /nobreak >nul
goto Level