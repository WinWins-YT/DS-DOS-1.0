@echo off
set /a level=1
:level
echo Guess number (0-10)
echo Level %level%
set /a cor=1+10*%random%/32768
set /p answ="Your guesses: "
if %answ%==%cor% goto Correct
if not %answ%==%cor% goto Incorrect

:Incorrect
echo Incorrect. Try again.
goto level

:Correct
echo Correct! You are Vanga?!
set /a level=%level%+1
goto level