@echo oN

call .\process\DVSN.BAT

set BAT_DIR=C:\Testprogram\QF7\BLT2
set LOG_DIR=C:\Testprogram\QF7\BLT2\LOG

:Test_Start
timeout /nobreak 1

:CARRIER_NPOE_DEVICE
set msg=CARRIER_NPOE_DEVICE
call Window-Client.exe CARRIER_ETH_NPOE_DEVICE > %LOG_DIR%\CARRIER_ETH_NPOE_DEVICE.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_NPOE_DEVICE.bat
if %CARRIER_ETH_NPOE_DEVICE%==PASS goto CARRIER_NPOE_SPEED
goto fail


:CARRIER_NPOE_SPEED
timeout /nobreak 1
set msg=CARRIER_NPOE_SPEED
call Window-Client.exe CARRIER_ETH_NPOE_SPEED > %LOG_DIR%\CARRIER_ETH_NPOE_SPEED.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_NPOE_SPEED.bat
if %CARRIER_ETH_NPOE_SPEED%==PASS goto CARRIER_NPOE_DUPLEX
goto fail



:CARRIER_NPOE_DUPLEX
set msg=CARRIER_NPOE_DUPLEX
call Window-Client.exe CARRIER_ETH_NPOE_DUPLEX > %LOG_DIR%\CARRIER_ETH_NPOE_DUPLEX.bat
timeout /nobreak 1
call %LOG_DIR%\CARRIER_ETH_NPOE_DUPLEX.bat
if %CARRIER_ETH_NPOE_DUPLEX%==PASS goto pass
goto fail


:pass
color 0f
>.\log\CARRIER_NPOE_LogCheck.bat echo set CARRIER_NPOE_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg CARRIER_NPOE
goto end

:fail
color 0C
echo %msg% fail
pause

goto end

:end