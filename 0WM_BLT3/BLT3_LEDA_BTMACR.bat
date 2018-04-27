@echo on

call .\process\DVSN.BAT
set BAT_DIR=C:\Testprogram\QF7\BLT3
set LOG_DIR=C:\Testprogram\QF7\BLT3\LOG

:Test_Start
timeout /nobreak 1



:GET_BTMAC
if exist %LOG_DIR%\BTmac.bat del %LOG_DIR%\BTmac.bat
call sdtGetDataFromSF.exe Mac %tmSN% > %LOG_DIR%\BTmac.bat
call %LOG_DIR%\BTmac.bat


:LEDA_BTMAC_READ
set msg=LEDA_BTMAC_READ
call Window-Client.exe BTMAC_READ > %LOG_DIR%\LEDA_BTMAC_READ.bat
call %LOG_DIR%\LEDA_BTMAC_READ.bat
if %BTMAC_READ%==%BTMAC% goto pass
goto fail


:pass
color 0f
>.\log\LEDA_BTMACR_LogCheck.bat echo set LEDA_BTMACR=%BTMAC_READ%
>>.\log\LEDA_BTMACR_LogCheck.bat echo set LEDA_BTMACR_TestResult=PASS
cd process
call sdtCheckLog.exe Model_MLBTEST.cfg LEDA_BTMACR
goto end

:fail
color 0C
echo %msg% fail
pause
echo %msg% fail
goto end

:end