@echo off

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT3
set LOG_DIR=C:\Testprogram\QF7\BLT3\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_INIT
set msg=CARRIER_INIT
call Window-Client.exe CARRIER_INIT > %LOG_DIR%\CARRIER_INIT.bat
call %LOG_DIR%\CARRIER_INIT.bat
if %CARRIER_INIT%==PASS goto LEDA_R
goto fail

:LEDA_R
set msg=LEDA_R
call Window-Client.exe LEDAB_R 0x0f> %LOG_DIR%\LEDAB_R.bat
timeout /nobreak 1
call Window-Client.exe LEDAB_R 0x0f > %LOG_DIR%\LEDAB_R.bat
call %LOG_DIR%\LEDAB_R.bat
if %LEDAB_R%==PASS goto LEDA_R_CHK
goto fail

:LEDA_R_CHK
msg.exe "检查LED是否有亮红色！" 2 700 200 12
echo **** Y(1).LED Pass    ****
echo **** N(0).LED Fail    ****
echo **** R(8).Retest LED  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto LEDB_R
if errorlevel 5 goto LEDB_R
if errorlevel 4 goto fail
if errorlevel 3 goto fail

:LEDA_G
set msg=LEDA_G
call Window-Client.exe LEDAB_G 0x0f> %LOG_DIR%\LEDAB_G.bat
call %LOG_DIR%\LEDAB_G.bat
if %LEDAB_G%==PASS goto LEDA_G_CHK
goto fail

:LEDA_G_CHK
msg.exe "检查LED是否有亮绿色！" 2 700 200 12
echo **** Y(1).LED Pass    ****
echo **** N(0).LED Fail    ****
echo **** R(8).Retest LED  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto LEDA_G
if errorlevel 5 goto LEDA_G
if errorlevel 4 goto fail
if errorlevel 3 goto fail

:LEDA_B
set msg=LEDA_B
call Window-Client.exe LEDAB_B 0x0f> %LOG_DIR%\LEDAB_B.bat
call %LOG_DIR%\LEDAB_B.bat
if %LEDAB_B%==PASS goto LEDA_B_CHK
goto fail

:LEDA_B_CHK
msg.exe "检查LED是否有亮蓝色！" 2 700 200 12
echo **** Y(1).LED Pass    ****
echo **** N(0).LED Fail    ****
echo **** R(8).Retest LED  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto LEDB_B
if errorlevel 5 goto LEDB_B
if errorlevel 4 goto fail
if errorlevel 3 goto fail

:LEDA_W
set msg=LEDA_W
call %LOG_DIR%\BTmac.bat
call Window-Client.exe LEDAB_W 0x0f > %LOG_DIR%\LEDAB_W.bat
call %LOG_DIR%\LEDAB_W.bat
if %LEDAB_W%==PASS goto LEDA_W_CHK
goto fail

:LEDA_W_CHK
msg.exe "检查LED是否有亮白色！" 2 700 200 12
echo **** Y(1).LED Pass    ****
echo **** N(0).LED Fail    ****
echo **** R(8).Retest LED  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto LEDA_W
if errorlevel 5 goto LEDA_W
if errorlevel 4 goto fail
if errorlevel 3 goto fail

:LEDA_O
set msg=LEDA_O
call Window-Client.exe LEDAB_O > %LOG_DIR%\LEDAB_O.bat
call %LOG_DIR%\LEDAB_O.bat
if %LEDAB_O%==PASS goto pass
goto fail

:pass
color 0f
>.\log\LEDA_RGB_LogCheck.bat echo set LEDA_RGB_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg LEDA_RGB
goto end

:fail
color 0C
echo %msg% fail
pause

goto end

:end