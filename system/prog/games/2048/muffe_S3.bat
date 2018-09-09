:S3
set version=0

call :ToZero

if [%contentR41%] == [%contentR31%] (call :Sum1000 contentR41 contentR31 content41 content31)
if [%contentR31%] == [%contentR21%] (call :Sum1000 contentR31 contentR21 content31 content21)
if [%contentR21%] == [%contentR11%] (call :Sum1000 contentR21 contentR11 content21 content11)

if [%contentR42%] == [%contentR32%] (call :Sum1000 contentR42 contentR32 content42 content32)
if [%contentR32%] == [%contentR22%] (call :Sum1000 contentR32 contentR22 content32 content22)
if [%contentR22%] == [%contentR12%] (call :Sum1000 contentR22 contentR12 content22 content12)

if [%contentR43%] == [%contentR33%] (call :Sum1000 contentR43 contentR33 content43 content33)
if [%contentR33%] == [%contentR23%] (call :Sum1000 contentR33 contentR23 content33 content23)
if [%contentR23%] == [%contentR13%] (call :Sum1000 contentR23 contentR13 content23 content13)

if [%contentR44%] == [%contentR34%] (call :Sum1000 contentR44 contentR34 content44 content34)
if [%contentR34%] == [%contentR24%] (call :Sum1000 contentR34 contentR24 content34 content24)
if [%contentR24%] == [%contentR14%] (call :Sum1000 contentR24 contentR14 content24 content14)

call :ToZero

exit /B

:ToZero

set rrnn=1
:PPNN
if [%contentR41%] == [0] (call :Zero1000 contentR41 contentR31 content41 content31)
if [%contentR31%] == [0] (call :Zero1000 contentR31 contentR21 content31 content21)
if [%contentR21%] == [0] (call :Zero1000 contentR21 contentR11 content21 content11)

if [%contentR42%] == [0] (call :Zero1000 contentR42 contentR32 content42 content32)
if [%contentR32%] == [0] (call :Zero1000 contentR32 contentR22 content32 content22)
if [%contentR22%] == [0] (call :Zero1000 contentR22 contentR12 content22 content12)

if [%contentR43%] == [0] (call :Zero1000 contentR43 contentR33 content43 content33)
if [%contentR33%] == [0] (call :Zero1000 contentR33 contentR23 content33 content23)
if [%contentR23%] == [0] (call :Zero1000 contentR23 contentR13 content23 content13)

if [%contentR44%] == [0] (call :Zero1000 contentR44 contentR34 content44 content34)
if [%contentR34%] == [0] (call :Zero1000 contentR34 contentR24 content34 content24)
if [%contentR24%] == [0] (call :Zero1000 contentR24 contentR14 content24 content14)
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