:W1
set version=0

call :ToZero

if [%contentR11%] == [%contentR21%] (call :Sum1000 contentR11 contentR21 content11 content21)
if [%contentR21%] == [%contentR31%] (call :Sum1000 contentR21 contentR31 content21 content31)
if [%contentR31%] == [%contentR41%] (call :Sum1000 contentR31 contentR41 content31 content41)

if [%contentR12%] == [%contentR22%] (call :Sum1000 contentR12 contentR22 content12 content22)
if [%contentR22%] == [%contentR32%] (call :Sum1000 contentR22 contentR32 content22 content32)
if [%contentR32%] == [%contentR42%] (call :Sum1000 contentR32 contentR42 content32 content42)

if [%contentR13%] == [%contentR23%] (call :Sum1000 contentR13 contentR23 content13 content23)
if [%contentR23%] == [%contentR33%] (call :Sum1000 contentR23 contentR33 content23 content33)
if [%contentR33%] == [%contentR43%] (call :Sum1000 contentR33 contentR43 content33 content43)

if [%contentR14%] == [%contentR24%] (call :Sum1000 contentR14 contentR24 content14 content24)
if [%contentR24%] == [%contentR34%] (call :Sum1000 contentR24 contentR34 content24 content34)
if [%contentR34%] == [%contentR44%] (call :Sum1000 contentR34 contentR44 content34 content44)

call :ToZero

exit /B

:ToZero

set rrnn=1
:PPNN
if [%contentR11%] == [0] (call :Zero1000 contentR11 contentR21 content11 content21)
if [%contentR21%] == [0] (call :Zero1000 contentR21 contentR31 content21 content31)
if [%contentR31%] == [0] (call :Zero1000 contentR31 contentR41 content31 content41)

if [%contentR12%] == [0] (call :Zero1000 contentR12 contentR22 content12 content22)
if [%contentR22%] == [0] (call :Zero1000 contentR22 contentR32 content22 content32)
if [%contentR32%] == [0] (call :Zero1000 contentR32 contentR42 content32 content42)

if [%contentR13%] == [0] (call :Zero1000 contentR13 contentR23 content13 content23)
if [%contentR23%] == [0] (call :Zero1000 contentR23 contentR33 content23 content33)
if [%contentR33%] == [0] (call :Zero1000 contentR33 contentR43 content33 content43)

if [%contentR14%] == [0] (call :Zero1000 contentR14 contentR24 content14 content24)
if [%contentR24%] == [0] (call :Zero1000 contentR24 contentR34 content24 content34)
if [%contentR34%] == [0] (call :Zero1000 contentR34 contentR44 content34 content44)
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