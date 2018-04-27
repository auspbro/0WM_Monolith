:Test_Start
echo oN
c:
cd c:\TestProgram\H6B\BLT1


call DVSN.BAT
if not %tmSN%==A1234567890 goto Start_MBtest

set BTMAC=ABCDEFGHIJKL
goto pass


:Start_MBtest
if exist BTmac.bat del BTmac.bat
call sdtGetDataFromSF.exe Mac %tmSN% >BTmac.bat
call BTmac.bat

call H6AMTP.exe COM1 BurnMAC_BT.txt BurnMAC_BT.bat %BTMAC%
ping 1.1.1.1 -n 1 -w 300 >nul
set errorlevel=
find /i "Pass" c:\TestProgram\H6B\BLT1\log\Report\BurnMAC_BT.bat
if not errorlevel 1 goto pass
goto end

:pass
call c:\TestProgram\H6B\BLT1\BTmac.bat
cd c:\TestProgram\H6B\BLT1\Process
>..\log\Test_BurnBTMACID_log.bat echo set BurnBTMACID=%BTMAC%
>>..\log\Test_BurnBTMACID_log.bat echo set TestResult=PASS
copy ..\log\Test_BurnBTMACID_log.bat ..\logtmp /y
call sdtCheckLog.exe Model_MLBTEST.cfg BurnBTMACID
goto end

:fail
call c:\TestProgram\H6B\BLT1\BTmac.bat
cd c:\TestProgram\H6B\BLT1\Process
>..\log\Test_BurnBTMACID_log.bat echo set BurnBTMACID=%BTMAC%
>>..\log\Test_BurnBTMACID_log.bat echo set TestResult=FAIL
copy ..\log\Test_BurnBTMACID_log.bat ..\logtmp /y
call sdtCheckLog.exe Model_MLBTEST.cfg BurnBTMACID
goto end

:end