@ECHO ON

:START
call .\process\dvsn.bat
REM set tmSN30=%tmSN:~6,30%
REM echo %tmSN30%
cd .\0WM_pycode

goto StartGUI
:ChkBSP
if exist C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreImgVer.cmd del C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreImgVer.cmd
python simple_tester.py test_lists\0WM_pre_Img_info.yml
call C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreImgVer.cmd
find /i "PRE_IMG_VER=0.0.5" C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreImgVer.cmd
if not errorlevel 1 goto CHKBIOS
goto BSP_CHECK_FAIL

:CHKBIOS
if exist C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreBiosVer.cmd del C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreBiosVer.cmd
python simple_tester.py test_lists\0WM_pre_check_bios.yml
call C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreBiosVer.cmd
find /i "PRE_BIOS_DATE=02/12/2018" C:\Testprogram\0WM\0WM_BLT1\0WM_pycode\Results\PreBiosVer.cmd
if not errorlevel 1 goto StartGUI
goto UpdateBIOS

:UpdateBIOS
python simple_tester.py test_lists\0WM_bios_update.yml

:StartGUI
python gui_runner.py %tmSN%
cd ..
goto pass

REM :HDMICHK
REM CD..
REM CALL .\Process\DVSN.BAT
REM set tmSN30=%tmSN:~6,30%
REM CALL .\log\%tmSN30%\result\HDMI_Input.cmd
REM find /i "connected" .\log\%tmSN30%\result\HDMI_Input.cmd
REM if not errorlevel 1 goto pass
REM GOTO FAIL

:PASS
>.\log\Test_HDMI_Status_CheckLog.bat echo set HDMI_Status=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg HDMI_Status
cd..
GOTO END

:FAIL
c:
cd c:\TestProgram\0WM\0WM_BLT1
RS232.exe poweroff 1000 A3
ECHO .****** TEST HDMI_Status FAIL! *******
MSG "TEST HDMI_Status FAIL!" 10 500 200 15
GOTO END

:BSP_CHECK_FAIL
ECHO .****** BSP Check FAIL! *******
MSG "BSP CHECK FAIL!" 10 500 200 15
pause
GOTO END


:END