@echo off

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_HDMI
set msg=CARRIER_HDMI
if exist %LOG_DIR%\CARRIER_HDMI.bat del %LOG_DIR%\CARRIER_HDMI.bat
call Window-Client.exe CARRIER_HDMI > %LOG_DIR%\CARRIER_HDMI.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_HDMI.bat
if %CARRIER_HDMI%==PASS goto HDMI_CHK
goto fail

:HDMI_CHK
msg.exe "检查HDMI屏幕是否有显示！" 5 700 200 12
echo **** Y(1).HDMI Pass    ****
echo **** N(0).HDMI Fail    ****
echo **** R(8).Retest HDMI  ****
choice /c:Y1N0R8 /N
if errorlevel 6 goto CARRIER_HDMI
if errorlevel 5 goto CARRIER_HDMI
if errorlevel 4 goto fail
if errorlevel 3 goto fail


:pass
color 0f
>.\log\IO_HDMI_LogCheck.bat echo set IO_HDMI_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg IO_HDMI
goto end

:fail
color 0C
echo %msg% fail
pause
goto end

:end