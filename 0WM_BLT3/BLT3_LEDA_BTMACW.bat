@echo on
PAUSE
call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT3
set LOG_DIR=C:\Testprogram\QF7\BLT3\LOG

:Test_Start
timeout /nobreak 1

:GET_BTMAC
if exist %LOG_DIR%\BTmac.bat del %LOG_DIR%\BTmac.bat
call sdtGetDataFromSF.exe Mac %tmSN% > %LOG_DIR%\BTmac.bat
call %LOG_DIR%\BTmac.bat

:LEDA_BTMAC_WRITE
set msg=LEDA_BTMAC_WRITE
call Window-Client.exe BTMAC_WRITE %BTMAC% > %LOG_DIR%\LEDA_BTMAC_WRITE.bat
call %LOG_DIR%\LEDA_BTMAC_WRITE.bat
if %BTMAC_WRITE%==PASS goto pass
goto fail


:pass
color 0f
>.\log\LEDA_BTMACW_LogCheck.bat echo set LEDA_BTMACW_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg LEDA_BTMACW
goto end

:fail
color 0C
echo %msg% fail
pause
goto end

:end