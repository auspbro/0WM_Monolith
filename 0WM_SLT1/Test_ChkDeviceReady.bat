@ECHO ON

:START
call .\process\dvsn.bat



:ChkDeviceReady
cd .\kud_pycode
if exist C:\Testprogram\KUD\KUD_SLT1\kud_pycode\Results\DeviceReady.cmd del C:\Testprogram\KUD\KUD_SLT1\kud_pycode\Results\DeviceReady.cmd
python simple_tester.py test_lists\kud_device_ready.yml
call C:\Testprogram\KUD\KUD_SLT1\kud_pycode\Results\DeviceReady.cmd
find /i "SET DevReady=PASS" C:\Testprogram\KUD\KUD_SLT1\kud_pycode\Results\DeviceReady.cmd
if not errorlevel 1 goto PASS
goto FAIL


:PASS
cd ..
>.\log\Test_ChkDeviceReady_Log.bat echo set ChkDeviceReady=PASS
cd .\Process
call sdtCheckLog.exe Model_SLT1.cfg ChkDeviceReady
cd..
GOTO END

:FAIL
color 4f
c:
cd c:\TestProgram\KUD\KUD_SLT1
ECHO .****** Check Device Ready FAIL! *******
MSG "TEST ChkDeviceReady FAIL!" 10 500 200 15
pause
GOTO END



:END