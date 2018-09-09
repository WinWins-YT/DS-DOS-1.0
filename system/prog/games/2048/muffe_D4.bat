:D4
set version=0

call :ToZero

if [%contentR14%] == [%contentR13%] (call :Sum1000 contentR14 contentR13 content14 content13)
if [%contentR13%] == [%contentR12%] (call :Sum1000 contentR13 contentR12 content13 content12)
if [%contentR12%] == [%contentR11%] (call :Sum1000 contentR12 contentR11 content12 content11)

if [%contentR24%] == [%contentR23%] (call :Sum1000 contentR24 contentR23 content24 content23)
if [%contentR23%] == [%contentR22%] (call :Sum1000 contentR23 contentR22 content23 content22)
if [%contentR22%] == [%contentR21%] (call :Sum1000 contentR22 contentR21 content22 content21)

if [%contentR34%] == [%contentR33%] (call :Sum1000 contentR34 contentR33 content34 content33)
if [%contentR33%] == [%contentR32%] (call :Sum1000 contentR33 contentR32 content33 content32)
if [%contentR32%] == [%contentR31%] (call :Sum1000 contentR32 contentR31 content32 content31)

if [%contentR44%] == [%contentR43%] (call :Sum1000 contentR44 contentR43 content44 content43)
if [%contentR43%] == [%contentR42%] (call :Sum1000 contentR43 contentR42 content43 content42)
if [%contentR42%] == [%contentR41%] (call :Sum1000 contentR42 contentR41 content42 content41)

call :ToZero

exit /B

:ToZero

set rrnn=1
:PPNN
if [%contentR14%] == [0] (call :Zero1000 contentR14 contentR13 content14 content13)
if [%contentR13%] == [0] (call :Zero1000 contentR13 contentR12 content13 content12)
if [%contentR12%] == [0] (call :Zero1000 contentR12 contentR11 content12 content11)

if [%contentR24%] == [0] (call :Zero1000 contentR24 contentR23 content24 content23)
if [%contentR23%] == [0] (call :Zero1000 contentR23 contentR22 content23 content22)
if [%contentR22%] == [0] (call :Zero1000 contentR22 contentR21 content22 content21)

if [%contentR34%] == [0] (call :Zero1000 contentR34 contentR33 content34 content33)
if [%contentR33%] == [0] (call :Zero1000 contentR33 contentR32 content33 content32)
if [%contentR32%] == [0] (call :Zero1000 contentR32 contentR31 content32 content31)

if [%contentR44%] == [0] (call :Zero1000 contentR44 contentR43 content44 content43)
if [%contentR43%] == [0] (call :Zero1000 contentR43 contentR42 content43 content42)
if [%contentR42%] == [0] (call :Zero1000 contentR42 contentR41 content42 content41)
set /a "rrnn+=1"
if [%rrnn%] LEQ [3] (goto PPNN)
exit /B

:Sum1000

set /a "PP=!%1!+!%2!"
if [%PP%] == [0] (exit /B)
set %1=%PP%
set %3=%PP%
set /a contor+=%PP%
IF %PP% LSS 1000 set "%3= %PP%"
IF %PP% LSS 100 set "%3=  %PP%"
IF %PP% LSS 10 set "%3=   %PP%"
set "%4=    "
set %2=0
set version=1
exit /B

:Zero1000

set /a "PP=!%1!+!%2!"
if [%PP%] == [0] (exit /B)
set %3=!%4!
set %1=!%2!
set "%4=    "
set %2=0
set version=1
exit /B