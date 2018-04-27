@ECHO On
call .\Process\DVSN.BAT
if #%tmSN%#==#A1234567890# goto DebugPASS

ECHO .*************************************
ECHO .****** TEST ( BLT2 ) ALL ITEM *******
ECHO .*************************************
REM MSG "TEST [ BLT2 ] ALL ITEM!" 20 700 400 15

adb pull /data/data/com.quanta.woa.mtp/files/BLT2.bat .\log
adb pull /data/data/com.quanta.woa.mtp/files/BLT1.bat .\log
if exist .\log\BLT1.bat goto startcheck
adb root
adb remount
adb pull /data/data/com.quanta.woa.mtp/files/BLT2.bat .\log
adb pull /data/data/com.quanta.woa.mtp/files/BLT1.bat .\log
if not exist .\log\BLT2.bat goto ISSUE
if not exist .\log\BLT1.bat goto ISSUE1
GOTO startcheck

:startcheck
CALL .\LOG\BLT1.BAT
echo ****WIFIID=%BLT1_sysinfo_wifiMac%****
set WIFIMACCHK=
for /f "tokens=1,2,3,4,5,6 delims=:" %%i in ('ECHO %BLT1_sysinfo_wifiMac%') do set WIFIMACCHK=%%i%%j%%k%%l%%m%%n
goto BINDMAC



:BINDMAC
COPY csBindMacSn_BACKUP.exe csBindMacSn.exe /Y
TIMEOUT 1
CALL csBindMacSn.exe WIFI %WIFIMACCHK% %tmSN% > .\log\bind.txt
find /i "Bind Mac and SN OK!" .\log\bind.txt && goto pass
goto NetIssue

:GetMAC
CALL csBindMacSn.exe /SET %tmSN% >.\log\GetSFMac.bat
ping 1.1.1.1 -n 1 -w 3000 >null
set WIFIMac=
for /f "tokens=2 delims==" %%i in ('find /i "WIFIMac=" .\log\GetSFMac.bat') do set WIFIMac=%%i 
if /i %WIFIMACCHK%==%WIFIMac% goto pass
goto END

:ISSUE
MSG "TEST [ BLT2 LOG ] NOT FIND! FAIL FIAL" 20 700 400 15
ECHO .*************************************
ECHO .****** TEST BLT2 LOG NOT FIND *******
ECHO .*************************************
PAUSE
GOTO END
:ISSUE1
MSG "TEST [ BLT1 sysinfo ] NOT FIND! FAIL FIAL" 20 700 400 15
ECHO .********************************************
ECHO .****** TEST BLT1 sysinfo LOG NOT FIND ******
ECHO .********************************************
PAUSE
GOTO END
:NetIssue
MSG "BAND WIFIMAC FAIL! CHECK NETWORK OR SF IS HAVE!" 20 800 400 12
ECHO .*************************************
ECHO .******   BAND WIFIMAC FAIL!   *******
ECHO .* CHECK NETWORK OR SF IS HAVE MAC! **
ECHO .*************************************
PAUSE
GOTO END

:PASS
>.\log\WIFIMACCheckLog.bat echo set WIFIMAC=PASS
>>.\log\WIFIMACCheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe QF6_BLT1.cfg WIFIMAC
cd..
GOTO END
:DEBUGPASS
>.\log\WIFIMACCheckLog.bat echo set WIFIMAC=DEBUGPASS
>>.\log\WIFIMACCheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe QF6_BLT1.cfg WIFIMAC
cd..
GOTO END
:FAIL
>.\log\WIFIMACCheckLog.bat echo set WIFIMAC=%WIFIMac%
>>.\log\WIFIMACCheckLog.bat echo set TestResult=FAIL
goto end
cd..
GOTO END
:end
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO -------------------------QF6 DUTLOG INFO------------------------------
TYPE .\LOG\BLT2.bat >>.\LOG\BLT4_QF6_ALLLOG.txt
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO -------------------------QF6 DUTLOG END------------------------------
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO -------------------------QF6 WIFIMAC INFO------------------------------
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO SET DUTWIFIMAC=%WIFIMACCHK%
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO SET SFBINDWIFIMAC=%MACID%
>>.\LOG\BLT4_QF6_ALLLOG.txt ECHO -------------------------QF6 WIFIMAC END------------------------------