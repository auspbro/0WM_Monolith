@echo off

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_ETH_POE_AT_TYPE
set msg=CARRIER_ETH_POE_AT_TYPE
if exist %LOG_DIR%\CARRIER_ETH_POE_AT_TYPE.bat del %LOG_DIR%\CARRIER_ETH_POE_AT_TYPE.bat
call Window-Client.exe CARRIER_ETH_POE_AT_TYPE > %LOG_DIR%\CARRIER_ETH_POE_AT_TYPE.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_POE_AT_TYPE.bat
if %POE_TYPE_AT%==PASS goto pass
goto fail


:pass
color 0f
>.\log\CARRIER_ETH_POE_AT_TYPE_LogCheck.bat echo set CARRIER_ETH_POE_AT_TYPE_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg CARRIER_ETH_POE_AT_TYPE
goto end

:fail
color 0C
echo %msg% fail
pause
goto end

:end