@echo off

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_HDMI
set msg=CARRIER_USB_EXT
if exist %LOG_DIR%\CARRIER_USB_EXT.bat del %LOG_DIR%\CARRIER_USB_EXT.bat
call Window-Client.exe CARRIER_USB_EXT > %LOG_DIR%\CARRIER_USB_EXT.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_USB_EXT.bat
if %CARRIER_USB_EXT%==PASS goto pass
goto fail


:pass
color 0f
>.\log\CARRIER_USB_EXT_LogCheck.bat echo set CARRIER_USB_EXT_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg CARRIER_USB_EXT
goto end

:fail
color 0C
echo %msg% fail
pause
goto Test_Start

:end