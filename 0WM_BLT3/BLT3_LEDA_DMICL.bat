@echo off

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT3
set LOG_DIR=C:\Testprogram\QF7\BLT3\LOG

:Test_Start
timeout /nobreak 1


:CARRIER_DMIC_LEFT
set msg=CARRIER_DMIC_LEFT
msg.exe "窗口消失后开始录音！" 2 700 200 12
call Window-Client.exe CARRIER_DMIC_LEFT > %LOG_DIR%\CARRIER_DMIC_LEFT.bat
call %LOG_DIR%\CARRIER_DMIC_LEFT.bat
if %CARRIER_DMIC_LEFT%==PASS goto CARRIER_DMIC_LEFT_PLAY
goto fail

:CARRIER_DMIC_LEFT_PLAY
msg.exe "请检查是否有听到声音！" 2 700 200 12
set msg=CARRIER_DMIC_LEFT_PLAY
call Window-Client.exe CARRIER_DMIC_L_PLAY > %LOG_DIR%\CARRIER_DMIC_LEFT_PLAY.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_DMIC_LEFT_PLAY.bat
if %CARRIER_DMIC_L_PLAY%==PASS goto DMIC_LEFT_PLAY_CHK
goto fail

:DMIC_LEFT_PLAY_CHK
echo **** Y(1).DMIC_LEFT_PLAY_CHK Pass    ****
echo **** N(0).DMIC_LEFT_PLAY_CHK Fail    ****
echo **** R(8).Retest DMIC_LEFT_PLAY_CHK  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto CARRIER_DMIC_LEFT
if errorlevel 5 goto CARRIER_DMIC_LEFT
if errorlevel 4 goto fail
if errorlevel 3 goto fail


:pass
color 0f
>.\log\LEDA_DMICL_LogCheck.bat echo set LEDA_DMICL_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg LEDA_DMICL
goto end

:fail
color 0C
echo %msg% fail
pause

goto end

:end