@echo on

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1


:IO_RJ45POE
set msg=IO_RJ45POE
call Window-Client.exe IO_RJ45POE > %LOG_DIR%\IO_RJ45POE.bat
call %LOG_DIR%\CARRIER_DMIC_RIGHT.bat
if %CARRIER_DMIC_RIGHT%==PASS goto pass
goto fail


:pass
color 0f
>.\log\IO_RJ45POE_LogCheck.bat echo set IO_RJ45POE_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg IO_RJ45POE
goto end

:fail
color 0C
echo %msg% fail
pause
goto end

:end