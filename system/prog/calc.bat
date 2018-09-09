@echo off
:calc
set /p first="Enter first number: "
set /p second="Enter second number: "
set /p opt="1-+ 2-- 3-* 4-/: "
if %opt%==1 goto Plus
if %opt%==2 goto Minus
if %opt%==3 goto Multi
if %opt%==4 goto Div
echo Error
goto calc

:Plus
set /a fin=%first%+%second%
echo Sum is %fin%
goto calc

:Minus
set /a fin=%first%-%second%
echo Minus is %fin%
goto calc

:Multi
set /a fin=%first%*%second%
echo Multiple is %fin%
goto calc

:Div
set /a fin=%first%/%second%
echo Divide is %fin%
goto calc