@ECHO OFF
CALL .\PROCESS\DVSN.BAT
IF /I #%tmSN%#==#A1234567890# goto debugpass

:GET_SFLANMAC
call sdtGetDataFromSF.exe MAC %tmSN% > .\log\LANMACALL.bat
call .\log\LANMACALL.bat

:WRITELANMAC
adb shell "echo %LANMAC1% > /sys/module/smsc9500/parameters/eth0_mac"
adb shell "echo %LANMAC2% > /sys/module/smsc9500/parameters/eth1_mac"
GOTO READMBSN

:READMBSN
adb shell "cat /sys/module/smsc9500/parameters/eth0_mac"
adb shell "cat /sys/module/smsc9500/parameters/eth1_mac"
timeout 2
CALL .\TOOL\read_lan1_mac.bat
CALL .\TOOL\read_lan2_mac.bat
GOTO CHECK

:CHECK
set READDUTLAN1=
for /f "tokens=1,2,3,4,5,6 delims=:" %%i in ('echo %read_eth0_mac%') do set READDUTLAN1=%%i%%j%%k%%l%%m%%n
set READDUTLAN2=
for /f "tokens=1,2,3,4,5,6 delims=:" %%i in ('echo %read_eth1_mac%') do set READDUTLAN2=%%i%%j%%k%%l%%m%%n
if /i #%READDUTLAN1%#==#%LANMAC1%# if /i #%READDUTLAN2%#==#%LANMAC2%# goto pass
GOTO FAIL

:PASS
>.\log\WriteLANMACCheckLog.bat echo set WriteLANMAC=%READDUTLAN1%_%READDUTLAN2%
>>.\log\WriteLANMACCheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe QF6_BLT1.cfg WriteLANMAC
cd..
goto end

:debugpass
>.\log\WriteLANMACCheckLog.bat echo set WriteLANMAC=DEBUGPASS
>>.\log\WriteLANMACCheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe QF6_BLT1.cfg WriteLANMAC
cd..
GOTO END

:FAIL
>.\log\WriteLANMACCheckLog.bat echo set WriteLANMAC=%READDUTLAN1%_%READDUTLAN2%
>>.\log\WriteLANMACCheckLog.bat echo set TestResult=FAIL
MSG "WriteLANMAC_Fail!!!!!" 20 700 400 15
GOTO END

:END
>>.\LOG\BLT2_QF6_ALLLOG.txt ECHO -------------------------LAN MAC INFO------------------------------
>>.\LOG\BLT2_QF6_ALLLOG.txt ECHO SET GETLANMAC=%LANMAC1%_%LANMAC2%
>>.\LOG\BLT2_QF6_ALLLOG.txt ECHO SET ReadLANMAC=%READDUTLAN1%_%READDUTLAN2%
>>.\LOG\BLT2_QF6_ALLLOG.txt ECHO -------------------------LAN MAC END ------------------------------