@ echo off
setlocal enabledelayedexpansion

call :init
call :scene 0 7

:continue
call :menu

:: ��஭� (1 - ��ப, 2 - ��������)
set side=%errorlevel%

call :start

:game
call :gameOver
call :show %finish%
if %finish% neq 0 goto finish
if %side% equ 1 (
  call :player
) else (
  call :computer
)
goto game

:finish
if %finish% equ 1 call :writeLn 1A " + + + �� �������� + + +"
if %finish% equ 2 call :writeLn 1C " - - - �� ��������� - - -"
echo:
pause
if %finish% equ 1 (
  mode con cols=80 lines=30
  call :scene 5 2
  mode con cols=80 lines=25
)
goto continue

:: ===============
:: ������� �������
:: ===============

:computer
:: ��� ��������
  0<nul set /p .=��� ��������: 
  call :state%state%
  if %kill% equ 1 (
    set play.%row%.%col%=1
  ) else (
    set play.%row%.%col%=-2
    set side=1
  )
exit /b

:state1
:: ����५
:: %row%  - ��ப� ����५�
:: %col%  - �⮫��� ����५�
:: %kill% - १���� ����५� (1 - �����, 0 - ����)
:: TODO: ��५��� �㤠, �㤠 ����� ���⠢��� ���ᨬ��쭮� �᫮ ��ࠡ��� ���ᨬ��쭮� �����
  call :rnd 0 9 row
  call :rnd 0 9 col
  call :freedom %row% %col% play
  if %errorlevel% equ 0 goto state1
  call :rnd 0 1 pki
  set /a pkj=pki-1
  for /l %%m in (1, 1, 2) do (
    set ln=0
    set k=0
    for /l %%n in (1, 1, 2) do (
      :state1_1
      set /a i=%row%+!pki!*!ln!
      set /a j=%col%+!pkj!*!ln!
      call :freedom !i! !j! play
      if !errorlevel! equ 1 (
        set /a k+=1
        set /a ln+=1
        goto state1_1
      )
      set /a pki=-!pki!
      set /a pkj=-!pkj!
      set ln=1    
    )
    call :maxShip
    if !k! geq !errorlevel! (
      set bool=1
      goto state1_2
    )
    set bool=0
    set pki=%pkj%
    set pkj=%pki%
  )
  :state1_2
  if %bool% equ 0 goto :state1
  call :killed %row% %col% kill
  if %kill% equ 1 (
    set pi=%row%
    set pj=%col%
    set len=1
    call :maxShip
    if !errorlevel! gtr 1 (set state=2) else set /a ship.1-=1
  )
exit /b

:state2
:: ����५
:: %row%  - ��ப� ����५�
:: %col%  - �⮫��� ����५�
:: %kill% - १���� ����५� (1 - �����, 0 - ����)
  set old=!play.%pi%.%pj%!
  set play.%pi%.%pj%=-1
  :state2_1
  set /a row=pi+pki
  set /a col=pj+pkj
  call :freedom %row% %col% play
  set plus=%errorlevel%
  set /a row=pi-pki
  set /a col=pj-pkj
  call :freedom %row% %col% play
  set minus=%errorlevel%
  if %plus% equ 0 if %minus% equ 0 (
    set pki=%pkj%
    set pkj=%pki%
  )
  call :rnd 0 1 rnd
  if %rnd% equ 0 (
    set /a row=%pi%+%pki%
    set /a col=%pj%+%pkj%
  ) else (
    set /a row=%pi%-%pki%
    set /a col=%pj%-%pkj%
  )
  call :freedom %row% %col% play
  if %errorlevel% equ 0 goto state2_1
  call :killed %row% %col% kill
  if %kill% equ 1 (
    set len=2
    set state=1
    call :maxShip
    if !errorlevel! gtr 2 (set state=3) else set /a ship.2-=1
  ) else (
    set k=4
    set ki=+1-1+0+0
    set kj=+0+0+1-1
    for /l %%n in (0, 2, 7) do (
      set /a i=%pi%!ki:~%%n,2!
      set /a j=%pj%!kj:~%%n,2!
      call :freedom !i! !j! play
      if !errorlevel! equ 0 set /a k-=1
    )
    if !k! lss 2 (
      set state=1
      set /a ship.1-=1
    )
  )
  set play.%pi%.%pj%=%old%
exit /b

:state3
:: �����५
:: %1 - 䫠�, 1 - ���� �஢�ઠ, ��� ����५�
:: %row%  - ��ப� ����५�
:: %col%  - �⮫��� ����५�
:: %kill% - १���� ����५� (1 - �����, 0 - ����)
:: TODO: ���� ���, �� �⬥⨫ �ࠧ� ������� ��ࠡ�� ��ப�
  set flag=0
  :state3_1
  set row=%pi%
  set col=%pj%
  :state3_2
  if !play.%row%.%col%! equ 1 (
    set /a row+=%pki%
    set /a col+=%pkj%
    goto state3_2
  )
  set /a i=%row%-%pki%
  set /a j=%col%-%pkj%
  set old=!play.%i%.%j%!
  set play.%i%.%j%=-1
  call :freedom %row% %col% play
  set bool=%errorlevel%
  set play.%i%.%j%=%old%
  if %bool% equ 1 goto state3_3
  set /a pki=-%pki%
  set /a pkj=-%pkj%
  if %flag% equ 1 goto state3_3
  set flag=1
  goto state3_1
  :state3_3
  if %bool% equ 1 (
    if not "%1"=="" exit /b
    call :killed %row% %col% kill
    if !kill! equ 1 (
      set /a len+=1
      call :maxShip
      if !errorlevel! equ !len! (
        set /a ship.!len!-=1
        set state=1
      )
    ) else (
      set trow=%row%
      set tcol=%col%
      set play.%row%.%col%=-2
      call :state3 1
      set row=!trow!
      set col=!tcol!
    )
  ) else (
    set /a ship.%len%-=1
    set state=1
    if "%1"=="" call :state1
  )
exit /b

:maxShip
:: ���� ����让 ��ࠡ�� ��ப�
:: %ERRORLEVEL% - ����� ᠬ��� ����讣� ��ࠡ�� (0 - ��ப �ந�ࠫ)
  setlocal
  set max=0
  for /l %%i in (1, 1, 4) do if !ship.%%i! gtr 0 set max=%%i
endlocal & exit /b %max%

:killed
:: �஢�ઠ 室� ��������
:: %1 - ��ப�
:: %2 - �⮫���
:: %3 - ��� ��६����� ��� ����� १���� (1 - �����, 0 - ����)
  setlocal
  call :coordToLabel %1 %2 aim
  echo %aim%
  echo:
  call :choice "����" "�����"
  endlocal & set /a %~3=%errorlevel%-1
exit /b

:player
:: ��� ��ப�
  set /p aim=��� 室: 
  call :labelToCoord "%aim%" row col
  set val=!comp.%row%.%col%!
  if "%val%"=="" goto player1
  if %val% equ 0 goto player2
  if %val% equ -1 goto player2
  :player1
  call :beep
  goto player
  :player2
  echo:
  if %val% equ 0 (
    call :writeLn 1A " + + + ����� + + +"
    set /a comp.%row%.%col%=1
  ) else (
    call :writeLn 1C " - - - ���� - - -"
    set /a comp.%row%.%col%=-2
    set side=2
  )
  echo:
  pause
exit /b

:coordToLabel
:: ������� ���� �� ���न��� 楫�
:: %1 - ��ப�
:: %2 - �⮫���
:: %3 - ��६����� ��� ����� ��⪨
  setlocal
  set cols=ABCDEFGHIJ
  set aim=!cols:~%2,1!%1
  endlocal & set %~3=%aim%
exit /b

:labelToCoord
:: ������� ���न���� 楫� �� ��⪨
:: %1 - ��⪠
:: %2 - ��६����� ��� ����� ��ப�
:: %3 - ��६����� ��� ����� �⮫��
  setlocal
  call :upperCase "%~1" aim
  set row=%aim:~-1%
  set col=%aim:~0,-1%
  set c=0
  for %%a in (A B C D E F G H I J) do (
    if "%%a"=="%col%" set col=!c!
    set /a c+=1
  )
  endlocal & set %~2=%row%&set %~3=%col%
exit /b

:gameOver
:: �஢�ઠ ����砭�� ����
:: %finish% - १���� (0 - ��� �த��������, 1 - ��ப �먣ࠫ, 2 - ��ப �ந�ࠫ)
  set finish=1
  for /l %%i in (0, 1, 9) do (
    for /l %%j in (0, 1, 9) do if !comp.%%i.%%j! equ 0 set finish=0
  )
  call :maxShip
  if %errorlevel% equ 0 set finish=2
exit /b

:init
:: ���樠������ ����
  mode con cols=80 lines=25
  title ���᪮� ��� (v1.0)
  color 1F
  cls
  call :randomize
exit /b

:scene
:: �������� ��ꥪ� �� �����
:: %1 - ����� ������ �����
:: %2 - ������⢮ ��ப ����
  setlocal
  set space=
  for /l %%i in (1, 1, 160) do set space= !space!
  set pos=-140
  :scene1
  set text=
  for /f "tokens=2* delims=#" %%s in ('findstr.exe /b /l "%1#" "%~f0"') do (
    if "%%s"=="." (
      set line=%space:~0,80%
    ) else (
      if %pos% lss 0 (
        set line=!space:~%pos%!%%s%space%
        set line=!line:~0,80!
      ) else (
        set line=%%s%space%
        set line=!line:~%pos%,80!
      )
    )
    set text=!text!!line!
  )
  set water=
  set /a cnt=%2 * 80
  for /l %%i in (1, 1, %cnt%) do set water=�!water!
  cls
  echo %text%%water%
  set /a pos+=1
  if %pos% leq 100 goto scene1
endlocal & exit /b

:menu
:: ������� ����
:: %ERRORLEVEL% - �� ��稭��� (1 - ��ப, 2 - ��������)
  setlocal
  cls
  call :print 1
  echo:
  echo ���� ����
  echo:
  call :choice "��ப ��稭���" "�������� ��稭���" "�ࠢ��� ����" "��室"
  set result=%errorlevel%
  cls
  if %result% equ 3 (
    call :print 2 1E
    goto menu
  )
  if %result% equ 4 exit 0
  call :print 3 1E
endlocal & exit /b %result%

:start
:: ����� ����
  call :print 4
  0<nul set /p .=����⠢��� ��ࠡ��: ����������������������������������������
  :: ���祭�� �� ��஢�� ����:
  ::  1 - ������� ��ࠡ��
  ::  0 - 楫� ��ࠡ��
  :: -1 - ��� ��ࠡ��
  :: -2 - �窠 �஬��
  call :ships comp
  call :diffic comp
  set maxDiffic=%errorlevel%
  :: ���孨� �।�� 横�� - ������⢮ ���⠭���� (40)
  for /l %%n in (1, 1, 40) do (
    0<nul set /p .=�
    call :ships tmpComp
    call :diffic tmpComp
    if !errorlevel! gtr !maxDiffic! (
      set maxDiffic=!errorlevel!
      call :copy tmpComp comp
    )
  )
  call :dispose tmpComp
  call :clear play
  for /l %%i in (1, 1, 4) do set /a ship.%%i=5 - %%i
  set state=1
  cls    
exit /b

:clear
:: ���⪠ ��஢��� ����
:: %1 - ��� ��६����� ��� ���⪨
  for /l %%i in (0, 1, 9) do (
    for /l %%j in (0, 1, 9) do set %~1.%%i.%%j=-1
  )
exit /b

:dispose
:: �᢮�������� ����� �� ��஢��� ����
:: %1 - ��� ��६����� ��� 㤠�����
  for /l %%i in (0, 1, 9) do (
    for /l %%j in (0, 1, 9) do set %~1.%%i.%%j=
  )
exit /b

:copy
:: ����஢���� ��஢��� ����
:: %1 - ��� ��६�����, ᮤ�ঠ饩 �����㥬�� ��஢�� ����
:: %2 - ��� ��६�����, �㤠 ����஢���
  for /l %%i in (0, 1, 9) do (
    for /l %%j in (0, 1, 9) do set %~2.%%i.%%j=!%~1.%%i.%%j!
  )
exit /b

:freedom
:: ��।������, ����� �� ���⠢��� �������㡭� ��ࠡ�� � �������� ������
:: %1 - ����� ��ப�
:: %2 - ����� �⮫��
:: %3 - ��� ��६�����, ᮤ�ঠ饩 ��஢�� ����
:: %ERRORLEVEL% - १���� (1 - �����, 0 - �����)
  setlocal
  set ki=+0+1+0-1+1-1+1-1
  set kj=+1+0-1+0+1+1-1-1
  set result=0
  if %1 geq 0 if %1 leq 9 if %2 geq 0 if %2 leq 9 if !%~3.%1.%2! equ -1 (
    for /l %%i in (0, 2, 15) do (
      set /a di=%1!ki:~%%i,2!
      set /a dj=%2!kj:~%%i,2!
      if !di! geq 0 if !di! leq 9 if !dj! geq 0 if !dj! leq 9 (
        set /a val=%~3.!di!.!dj!
        if !val! geq 0 goto freedom1
      )
    )
    set result=1
  )
  :freedom1
endlocal & exit /b %result%

:diffic
:: ����� ᫮����� ��஢�� ����樨
:: %1 - ��� ��६�����, ᮤ�ঠ饩 ��஢�� ����
:: %ERRORLEVEL% - १����
  setlocal
  set result=0
  for /l %%i in (0, 1, 9) do (
    for /l %%j in (0, 1, 9) do (
      call :freedom %%i %%j "%~1"
        if !errorlevel! equ 1 set /a result+=1
    )
  )
endlocal & exit /b %result%

:ships
:: ����⠭���� ��ࠡ��� ��������
:: %1 - ��� ��६�����, ᮤ�ঠ饩 ��஢�� ����
  call :clear "%~1"
  for /l %%n in (3, -1, 0) do (
    set /a cnt=3-%%n
    for /l %%m in (0, 1, !cnt!) do call :build %%n "%~1"
  )
exit /b

:build
:: �����饭�� ��ࠡ�� �� ��஢�� ����
:: %1 - ࠧ��� ��ࠡ�� �� ������� ����� ��⠭����������� (0-3)
:: %2 - ��� ��६�����, ᮤ�ঠ饩 ��஢�� ����
  set /a i0=%random% %% 10
  set /a j0=%random% %% 10
  set /a ki=%random% %% 2
  set /a kj=1-ki
  for /l %%n in (0, 1, %1) do (
    set /a i=i0+ki*%%n
    set /a j=j0+kj*%%n
    call :freedom !i! !j! "%~2"
    if !errorlevel! equ 0 (
      goto build
    )
  )
  for /l %%n in (0, 1, %1) do (
    set /a i=i0+ki*%%n
    set /a j=j0+kj*%%n
    set /a %~2.!i!.!j!=0
  )
exit /b

:show
:: �뢮� ��஢�� ���樨
:: %1 - 䫠�, 0 - �� �����뢠�� ��ࠡ�� ��������
  setlocal
    cls
    echo:
    echo       ���� ��������           ���� ��ப�      
    echo:
    echo     A B C D E F G H I J     A B C D E F G H I J     ��ࠡ�� ��ப�
    echo    �������������������Ŀ   �������������������Ŀ
    set len=4
    set cnt=1
    set c=0
    for /l %%i in (0, 1, 9) do (
      :: ���� ��������
      set line=  %%i�
      for /l %%j in (0, 1, 9) do (
        set cell=�
        set val=!comp.%%i.%%j!
        if !val! equ 0 if not "%~1"=="0" set cell=�
        if !val! equ -2 set cell=�
        if !val! equ 1 set cell=*
        set line=!line!!cell! 
      )
      :: ���� ��ப�
      set line=!line!�  %%i�
      for /l %%j in (0, 1, 9) do (
        set cell=�
        set val=!play.%%i.%%j!
        if !val! equ -2 set cell=�
        if !val! equ 1 set cell=*
        set line=!line!!cell! 
      )
      set line=!line!�       
      :: ��ࠡ�� ��ப�
      set /a alives=ship.!len!
      if !c! lss !alives! (set cell=�) else set cell=*
      for /l %%j in (1, 1, !len!) do (
        set line=!line!!cell! 
      )
      set /a c+=1
      if !c! equ !cnt! (
        set /a len-=1
        set /a cnt+=1
        set c=0
      )
      echo !line!
    )
    echo    ���������������������   ���������������������
    echo:
endlocal & exit /b

:: =======================
:: ��������������� �������
:: =======================

:print
:: �뢮� ⥪�� �� �����
:: %1 - ����� ������ �����
:: %2 - 梥� ��ࢮ� ��ப� (����易⥫�� ��ࠬ���)
  setlocal
  set first=1
  for /f "tokens=2* delims=#" %%s in ('findstr.exe /b /l "%1#" "%~f0"') do (
    if "%%s"=="~" (
      pause
      cls
      set first=1
    ) else (
      if !first! equ 1 (
        if not "%~2"=="" (
          call :writeLn %~2 "%%s"
          if not "%%s"=="." set first=0
        ) else echo%%s
      ) else echo%%s
    )
  )
endlocal & exit /b

:write
:: �뢥�� 梥��� ������� ��� ��ॢ��� ��ப�
:: %1 - 梥�
:: %2 - ⥪�� ������
:: %3 - 䫠�, �� ���祭��, �᫨ �㦭� �����稥 � ���� ��ப�
  setlocal
  :write1
  set "tempFolder=%TEMP%\%~n0.%time:~-2%.%random%"
  md "%tempFolder%" 2>nul || goto write1
  pushd %tempFolder%
  set /p .=.<nul>"%~2"
  findstr /a:%~1 /c:"." /s "%~2"
  if "%~3"=="" (set /p .=  <nul) else set /p .= <nul
  popd
  rd /s /q "%tempFolder%" 2>nul
endlocal & exit /b

:writeLn
:: �뢥�� 梥��� ������� � ��ॢ���� ��ப�
:: %1 - 梥�
:: %2 - ⥪�� ������
:: %3 - 䫠�, �� ���祭��, �᫨ �㦭� �����稥 � ���� ��ப�
  call :write %1 "%~2" %3
  echo:
exit /b

:choice
:: �롮� ���짮��⥫�� ������ �� ��ਠ�⮢
:: ��ࠬ���� - ��ਠ��� �롮�
:: %ERRORLEVEL% - ��࠭�� ��ਠ��
  setlocal
  if "%~1"=="" (
    set result=0
    pause
    goto choice3
  )
  set count=0
  :choice1
  set /a count+=1
  echo  %count%. %~1
  shift
  if not "%~1"=="" goto choice1
  :choice2
  set /p result=��� �롮� (1-%count%): 
  for /l %%i in (1, 1, %count%) do if "%result%"=="%%i" goto choice3
  call :beep
  goto choice2
  :choice3
endlocal & exit /b %result%

:beep
:: ����� ��㪮���� ᨣ����
  setlocal
  0<nul set /p strTemp=
endlocal & exit /b

:upperCase
:: �८�ࠧ������ ⥪�⮢�� ��ப� � ���孥�� ॣ�����
:: %1 - ��室��� ��ப�
:: %2 - ��६����� ��� ����� १����
  setlocal
  set strTemp=%~1
  for %%a in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �) do set strTemp=!strTemp:%%a=%%a!
  endlocal & set %~2=%strTemp%
exit /b

:randomize
:: ��������� ���稪� ��砩��� �ᥫ
  setlocal
  set rndTemp=%random%
endlocal & exit /b

:rnd
:: ������� ��砩���� �᫠ �� ��������� ���������
:: %1 - �������쭮� ���祭��
:: %2 - ���ᨬ��쭮� ���祭��
:: %3 - ��� ��६����� ��� ����� १����
  set /a %~3=%1+(%2-%1+1)*%random%/32768
exit /b

:: =================
:: ��������� �������
:: =================

:: ��ࠡ��
0#.
0#                           -                    
0#                          3                
0#                                        
0#                      3                      
0#              q$v        $               
0#                        
0#         v                            
0#           -                      q         
0#        v          -              
0#    o      q       - 3         
0#                                          
0#                                 
0#                          -
0#                
0#              -     

:: ����⨯
1#.
1#                                                ���                    ���    
1#.
1#      ��   ��  ����  ����   ����  �� ��  ����  ��  ��     ����  ����  ��  ��  
1#      ��   �� ��  �� �� �� ��  �� �� �� ��  �� �� ���     ��   ��  �� �� ���  
1#      ��� ��� ��  �� �� �� ��     ����  ��  �� �� ���     ��   ��  �� �� ���  
1#      ��� ��� ��  �� �� �� ��     ���   ��  �� �� ���     ���� ��  �� �� ���  
1#      ��� ��� ��  �� ����  ��     ����  ��  �� ��� ��     �� ����  �� ��� ��  
1#      �� � �� ��  �� ��    ��  �� �� �� ��  �� ��� ��     �� ����  �� ��� ��  
1#      �� � �� ��  �� ��    ��  �� �� �� ��  �� ��� ��     �� ����  �� ��� ��  
1#      �� � ��  ����  ��     ����  �� ��  ����  ��  ��     ����  ����  ��  ��
1#.

:: �ࠢ��� ����
2#                     ������� ���� ������� ��� (���. 1 �� 2)
2#.
2# "���᪮� ���" - ��� ��� ����  ���⭨���, � ���ன  ��ப� �� ��।� ���뢠�⪮�न���� �� �������⭮� �� ���� ᮯ�୨��. �᫨ � ᮯ�୨�� �� �⨬ ���न��-⠬ �������  ��ࠡ�� (���न���� ������), � ��ࠡ��  ��� ��� ���� "⮯����", ������訩 ����砥� �ࠢ�  ᤥ���� �� ���� 室. ���� ��ப� - ���� ��ࠧ��� �ᥪ�ࠡ�� ��⨢����.
2#.
2# ��஢�� ���� - ������ 10x10 ������� ��ப�, �� ���஬  ࠧ��頥��� 䫮� ��ࠡ-���. ��ਧ��⠫�  �㬥������ ᢥ���  ���� (0-9), � ���⨪���  ��������� �㪢���᫥�� ���ࠢ� (A-J).
2#.
2# ����������:
2#    1 ��ࠡ�� - �� �� 4 ���⮪ ("����寠�㡭�")
2#    2 ��ࠡ�� - �� �� 3 ���⮪ ("��寠�㡭�")
2#    3 ��ࠡ�� - �� �� 2 ���⮪ ("���寠�㡭�")
2#    4 ��ࠡ�� - 1 ���⪠ ("�������㡭�")
2# �� ࠧ��饭�� ��ࠡ�� �� ����� ������� ��� ��㣠 㣫���.
2#.
2# �冷� � "᢮��" �����⮬  ������ "�㦮�"  ⠪��� �� ࠧ���, ⮫쪮  ���⮩.�� ���⮪ ����, ��� ������� �㦨� ��ࠡ�� ��⨢����.
2# �� ��������� � ��ࠡ��  ��⨢���� - �� �㦮�  ���� �⠢����  ���⨪. �����訩��५�� �� ࠧ.
2#.
2#~
2#                     ������� ���� ������� ��� (���. 2 �� 2)
2#.
2# ��। ��砫�� ������ ����⢨� ��ப� ������ਢ�����, �� �㤥� 室��� ����.
2#.
2# ��ப, �믮����騩 室, ᮢ��蠥� ����५ - 㪠�뢠�� ���न���� ���⪨, � ���-ன, �� ��� ������, ��室���� ��ࠡ�� ��⨢����, ���ਬ��, "J0" (������ �ࠢ�磌�⪠).
2#.
2#    1. �᫨ ����५  ��襫�� � �����, �� ������� �� �����  ��ࠡ��� ��⨢����,� ᫥��� �⢥� "����" � ��५�訩 ��ப �⠢�� �� �㦮� ������ � �⮬ �������. �ࠢ� 室� ���室�� � ᮯ�୨��.
2#.
2#    2. �᫨ ����५  ��襫�� � �����, ��� ��室����  ��ࠡ��, � ᫥���  �⢥�"�����". ��५�訩 ��ப �⠢�� �� �㦮�  ���� � ��� ����� ���⨪, � ��� ��-⨢��� �⠢��  ���⨪ �� ᢮�� ���� ⠪�� � ��� �����. ��५�訩  ��ப ����-砥� �ࠢ� �� �� ���� ����५.
2#.
2# ������⥫�� ��⠥��� ��, �� ���� ��⮯�� �� 10 ��ࠡ��� ��⨢����. �ந�-ࠢ訩 ����� �ࠢ� ������ ��᫥ ����砭�� ���� � ᮯ�୨�� ��஢�� ����.
2#.
2#~

:: ���᪠��� � ��砫� ����
3#                               ��������� � ����
3#.
3# ��� ���� ��� ����������� ���� ��ࠤ�� ���⮪ � ������.
3# ������ �� ���� ��� ��஢�� ���� ࠧ��஬ 10x10 ���⮪ ������:
3#.
3#       A B C D E F G H I J       A B C D E F G H I J
3#     _|_|_|_|_|_|_|_|_|_|_|    _|_|_|_|_|_|_|_|_|_|_|
3#    0_|_|_|_|_|_|_|_|_|_|_|   0_|_|_|_|_|_|_|_|_|_|_|
3#    1_|_|_|_|_|_|_|_|_|_|_|   1_|_|_|_|_|_|_|_|_|_|_|
3#    2_|_|_|_|_|_|_|_|_|_|_|   2_|_|_|_|_|_|_|_|_|_|_|
3#    3_|_|_|_|_|_|_|_|_|_|_|   3_|_|_|_|_|_|_|_|_|_|_|
3#    4_|_|_|_|_|_|_|_|_|_|_|   4_|_|_|_|_|_|_|_|_|_|_|
3#    5_|_|_|_|_|_|_|_|_|_|_|   5_|_|_|_|_|_|_|_|_|_|_|
3#    6_|_|_|_|_|_|_|_|_|_|_|   6_|_|_|_|_|_|_|_|_|_|_|
3#    7_|_|_|_|_|_|_|_|_|_|_|   7_|_|_|_|_|_|_|_|_|_|_|
3#    8_|_|_|_|_|_|_|_|_|_|_|   8_|_|_|_|_|_|_|_|_|_|_|
3#    9_|_|_|_|_|_|_|_|_|_|_|   9_|_|_|_|_|_|_|_|_|_|_|
3#.
3# �஭㬥��� ���⪨, ��� �������� �� ��㭪�.
3#.
3# ��ᯮ����� �� ����� ���� ᢮� ��ࠡ�� � ᮮ⢥��⢨� � �ࠢ����� ����.
3#.
3#~

:: ���
4#                       ...^v^
4#                                    $:... ^v^..
4#                           ... ^v^     $$
4#                                    $ $$
4#                                    $$$ :..... ^v^
4#                        ... ^v^       $$ .
4#                                  $$$ 
4#                                  $ $  :::..... ^v^
4#                                 $$ $  
4#                                $$$ $  
4#                               $$$$ $  
4#                              $$$$$ $  
4#                            $$$$$$$ $  
4#                           $$$$$$$$ $ 
4#                        $ $$$$$$$$$ $ 
4#                        $$ $        $$$     $$$$$   $$
4#                         $$$$$$$$$$$$$$$$$$$$$$$ $$$$.
4#                          $$$$$$$$$$$$$$$$$$$$$$$$$$
4#  ..-+*�*+-..  ~~~*�*~~~  ..-+*�*+-.. ..-+*�*+-..  ~~~*�*~~~  ..-+*�*+-.. ~~~*�
4# ~~~  ..-+*�*+-..~~~~  ..-+*�*+-.. ~~~  ..-+*�*+-..~~~~  ..-+*�*+-.. ..-+*�*+-..
4#  ..-+*~~�*+-..  ..-+*~~~~�*+-.. *+-...-+*� ..-+*~~�*+-..  ..-+*~~~~�*+-.. *+-..
4#  .~*�*~~~~  ..-+*~~~~�*+-.. *.-+*�*+-.. .~*�*~~~~  ..-+*~~~~�*+-.. *.-+*�*+-.. 
4#.

:: �ॣ��
5#                                gg                            
5#                cggN            NgT            Fgg            
5#                iggc      Tggggggg              KN            
5#           gggggggg        Bgggggg        Fggggggh            
5#            Ngggggg       TNNhhhdg         KgggggN            
5#           gggggggg       gggggggggggggggTHhhhHhNh            
5#                 gg        Fggggggggggggg       Ah            
5#          Ngggggggggggggg Eggggggggggggg  Fggggggggggggg      
5#           dgggggggggggF ggggggggggggggR YggggggggggggH       
5#         AggggggggggggR TgggggggggggggN  ggggggggggggg        
5#         ggggggggggggg  HgggggggggggggB  ggggggggggggg        
5#         ggggggggggggg  NgggggggggggggH cggggggggggggg        
5#       dgggggggggggggg  RggggggggggggggTYggggggggggggg        
5#  gggggi gggggggggggggI  ggggggggggggggg ggggggggggggggR  hgg 
5#  YRgA   ggggggggggggggF ggggggggggggggKIggggggggggggggg  cdI 
5#    dgK    Hg  hgggNdgh    gN Kgggggggd    ggFgTgh      Fgg   
5#     gg   YgX ggRggRgXg  igK gg ggNigFgg  gc gATgN     KggK   
5#      Bgggg  gB EgggggggggAigE  ggggcgEEggihgTgggggggggggg    
5#       gggggdgHhhggKghgdRgNggHhHggghgNggKgBdhggggggggggggi    
5#        Aggggggggggggggggggggggggggggggggggggggggggggggg      
5#         ggggggggggggggggggggggggggggggggggggggggggggggB      
5#          TgggggT  Iggg  Hggh  ggg  Tggg   ggggggggggT        
5#           ggggggggggggggggggggggggggggggggggggggggggg        
5#             gggggggggggggggggggggggggggggggggggggggg         
5#             KHBHBBHHHHBHBHHBHHHgghBBBHBHBBBBBBBBBBBF 
