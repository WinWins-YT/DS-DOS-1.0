@echo off
title muffe (Game 2048 for Command prompt)
if not exist muffe_BestSc.txt echo 0>muffe_BestSc.txt
(set /p BestSc=)<muffe_BestSc.txt
set BestSc=%BestSc: =%
:Begin1
cls

SETLOCAL ENABLEDELAYEDEXPANSION

set "echo2=echo ÚÄÄÄÄ¿ÚÄÄÄÄ¿ÚÄÄÄÄ¿ÚÄÄÄÄ¿"
set "echo3=echo ÀÄÄÄÄÙÀÄÄÄÄÙÀÄÄÄÄÙÀÄÄÄÄÙ"
set contor=0


:::::::::::::::::::::::::::::::::::::::::::::::::

set contentR11=0
set contentR12=0
set contentR13=0
set contentR14=0

set contentR21=0
set contentR22=0
set contentR23=0
set contentR24=0

set contentR31=0
set contentR32=0
set contentR33=0
set contentR34=0

set contentR41=0
set contentR42=0
set contentR43=0
set contentR44=0

:::::::::::::::::::::::::::::::::::::::::::::::::

set /a "X=%RANDOM% * 100 / 32768 + 1"
if [%X%] LEQ [90] set cell=2
if [%X%] GEQ [91] set cell=4

:::::::::::::::::::::::::::::::::::::::::::::::::

set /a "X=%RANDOM% * 4 / 32768 + 1"
set /a "Y=%RANDOM% * 4 / 32768 + 1"
set contentR%Y%%X%=%cell%
set "content%Y%%X%=   %cell%"

set exitC=0

:::::::::::::::::::::::::::::::::::::::::::::::::

if [%contentR11%] == [0] (set "content11=    ")
if [%contentR12%] == [0] (set "content12=    ")
if [%contentR13%] == [0] (set "content13=    ")
if [%contentR14%] == [0] (set "content14=    ")

if [%contentR21%] == [0] (set "content21=    ")
if [%contentR22%] == [0] (set "content22=    ")
if [%contentR23%] == [0] (set "content23=    ")
if [%contentR24%] == [0] (set "content24=    ")

if [%contentR31%] == [0] (set "content31=    ")
if [%contentR32%] == [0] (set "content32=    ")
if [%contentR33%] == [0] (set "content33=    ")
if [%contentR34%] == [0] (set "content34=    ")

if [%contentR41%] == [0] (set "content41=    ")
if [%contentR42%] == [0] (set "content42=    ")
if [%contentR43%] == [0] (set "content43=    ")
if [%contentR44%] == [0] (set "content44=    ")

set version=1

:Direction


::::::::::::::::::::::::::::::::::::::::

set exitC=0

:Rand
set /a "exitC+=1"
if [%exitC%] == [60] (goto Exit1)

set /a "X=%RANDOM% * 100 / 32768 + 1"
if [%X%] LEQ [90] set cell=2
if [%X%] GEQ [91] set cell=4

set /a "X=%RANDOM% * 4 / 32768 + 1"
set /a "Y=%RANDOM% * 4 / 32768 + 1"
set name=contentR%Y%%X%

if [!%name%!] == [0] (set %name%=%cell%
) else (goto Rand)
set "content%Y%%X%=   %cell%"
if [%version%] == [0] goto Anulare


::::::::::::::::::::::::::::::::::::::::

if %contor% GTR %BestSc% set BestSc=%contor%

:Cls1
cls

%echo2%
echo ³%content11%³³%content12%³³%content13%³³%content14%³    Score = %contor%
%echo3%
%echo2%
echo ³%content21%³³%content22%³³%content23%³³%content24%³
%echo3%
%echo2%
echo ³%content31%³³%content32%³³%content33%³³%content34%³
%echo3%
%echo2%
echo ³%content41%³³%content42%³³%content43%³³%content44%³    BestS = %BestSc%
%echo3%
echo(
echo WASD or X or R

choice /C wasdxr /N >nul

if errorlevel 6 (goto Begin1)
if errorlevel 5 (goto Exit1)
if errorlevel 4 (goto D4)
if errorlevel 3 (goto S3)
if errorlevel 2 (goto Aa2)
if errorlevel 1 (goto W1)
if errorlevel 0 (goto Direction)

:::::::::::::::::::::::::::::::::::::::::

:D4
call muffe_D4.bat
goto Direction

:S3
call muffe_S3.bat
goto Direction

:Aa2
call muffe_Aa2.bat
goto Direction

:W1
call muffe_W1.bat
goto Direction

:::::::::::::::::::::::::::::::::::::::::

:Anulare
set contentR%Y%%X%=0
set "content%Y%%X%=    "
goto Cls1


:Exit1
cd..
cd..
cd..
echo %BestSc% >muffe_BestSc.txt
