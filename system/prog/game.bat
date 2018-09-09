@echo off
echo ===============================
echo  Welcome to DS-DOS Game Center
echo ===============================
echo.
echo Checking updates...
timeout /t 5 /nobreak >nul
echo Not checked
:games
echo Installed games:
echo 1. Guess number
echo 2. Sum is...
echo 3. Snake
echo 4. 2048
echo 5. Sea Battle
choice /c:12345
if errorlevel 5 start /wait prog\games\SeaBattle.bat
if errorlevel 4 goto 2048
if errorlevel 3 start /wait prog\games\snake.bat
if errorlevel 2 start /wait prog\games\sum.bat
if errorlevel 1 start /wait prog\games\guess.bat
goto games

:2048
cd prog\games\2048
start /wait muffe9.bat
cd..
cd..
cd..
goto games