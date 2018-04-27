@echo on

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1



:IO_USB_PROT2
set msg=IO_USB_PROT2
call Window-Client.exe CARRIER_BL_PWM_FULL > %LOG_DIR%\CARRIER_BL_PWM_FULL.bat
call %LOG_DIR%\CARRIER_BL_PWM_FULL.bat
if %CARRIER_BL_PWM_FULL%==PASS goto pass
goto fail


:pass
color 0f
>.\log\IO_USB2_LogCheck.bat echo set IO_USB2_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg IO_USB2
goto end

:fail
color 0C
echo %msg% fail
pause
echo %msg% fail
goto end

:end