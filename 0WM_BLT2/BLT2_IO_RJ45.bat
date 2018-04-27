@echo on

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:IO_RJ45
set msg=IO_RJ45
call Window-Client.exe CARRIER_HW_VERSION > %LOG_DIR%\CARRIER_CPLD_HW_VERSION.bat
call %LOG_DIR%\CARRIER_CPLD_HW_VERSION.bat
if %CARRIER_HW_VERSION%==PASS goto pass
goto fail


:pass
color 0f
>.\log\IO_RJ45_LogCheck.bat echo set IO_RJ45_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg IO_RJ45
goto end

:fail
color 0C
echo %msg% fail
pause

goto end

:end