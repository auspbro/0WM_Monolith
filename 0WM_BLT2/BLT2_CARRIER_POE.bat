@echo off

call .\process\DVSN.BAT

set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_POE_DEVICE
set msg=CARRIER_POE_DEVICE
call Window-Client.exe CARRIER_ETH_POE_DEVICE > %LOG_DIR%\CARRIER_ETH_POE_DEVICE.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_POE_DEVICE.bat
if %CARRIER_ETH_POE_DEVICE%==PASS goto CARRIER_POE_SPEED
goto fail


:CARRIER_POE_SPEED
timeout /nobreak 1
set msg=CARRIER_POE_SPEED
call Window-Client.exe CARRIER_ETH_POE_SPEED > %LOG_DIR%\CARRIER_ETH_POE_SPEED.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_POE_SPEED.bat
if %CARRIER_ETH_POE_SPEED%==PASS goto CARRIER_POE_DUPLEX
goto fail



:CARRIER_POE_DUPLEX
set msg=CARRIER_POE_DUPLEX
call Window-Client.exe CARRIER_ETH_POE_DUPLEX > %LOG_DIR%\CARRIER_ETH_POE_DUPLEX.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_POE_DUPLEX.bat
if %CARRIER_ETH_POE_DUPLEX%==PASS goto pass
goto fail


:pass
color 0f
>.\log\CARRIER_POE_LogCheck.bat echo set CARRIER_POE_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg CARRIER_POE
goto end

:fail
color 0C
echo %msg% fail
pause

goto end

:end