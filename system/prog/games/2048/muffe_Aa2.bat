:Aa2
set version=0

call :ToZero

if [%contentR11%] == [%contentR12%] (call :Sum1000 contentR11 contentR12 content11 content12)
if [%contentR12%] == [%contentR13%] (call :Sum1000 contentR12 contentR13 content12 content13)
if [%contentR13%] == [%contentR14%] (call :Sum1000 contentR13 contentR14 content13 content14)

if [%contentR21%] == [%contentR22%] (call :Sum1000 contentR21 contentR22 content21 content22)
if [%contentR22%] == [%contentR23%] (call :Sum1000 contentR22 contentR23 content22 content23)
if [%contentR23%] == [%contentR24%] (call :Sum1000 contentR23 contentR24 content23 content24)

if [%contentR31%] == [%contentR32%] (call :Sum1000 contentR31 contentR32 content31 content32)
if [%contentR32%] == [%contentR33%] (call :Sum1000 contentR32 contentR33 content32 content33)
if [%contentR33%] == [%contentR34%] (call :Sum1000 contentR33 contentR34 content33 content34)

if [%contentR41%] == [%contentR42%] (call :Sum1000 contentR41 contentR42 content41 content42)
if [%contentR42%] == [%contentR43%] (call :Sum1000 contentR42 contentR43 content42 content43)
if [%contentR43%] == [%contentR44%] (call :Sum1000 contentR43 contentR44 content43 content44)

call :ToZero

exit /B

:ToZero

set rrnn=1
:PPNN
if [%contentR11%] == [0] (call :Zero1000 contentR11 contentR12 content11 content12)
if [%contentR12%] == [0] (call :Zero1000 contentR12 contentR13 content12 content13)
if [%contentR13%] == [0] (call :Zero1000 contentR13 contentR14 content13 content14)

if [%contentR21%] == [0] (call :Zero1000 contentR21 contentR22 content21 content22)
if [%contentR22%] == [0] (call :Zero1000 contentR22 contentR23 content22 content23)
if [%contentR23%] == [0] (call :Zero1000 contentR23 contentR24 content23 content24)

if [%contentR31%] == [0] (call :Zero1000 contentR31 contentR32 content31 content32)
if [%contentR32%] == [0] (call :Zero1000 contentR32 contentR33 content32 content33)
if [%contentR33%] == [0] (call :Zero1000 contentR33 contentR34 content33 content34)

if [%contentR41%] == [0] (call :Zero1000 contentR41 contentR42 content41 content42)
if [%contentR42%] == [0] (call :Zero1000 contentR42 contentR43 content42 content43)
if [%contentR43%] == [0] (call :Zero1000 contentR43 contentR44 content43 content44)
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