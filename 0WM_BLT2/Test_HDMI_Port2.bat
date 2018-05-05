@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/28/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem 
@rem 
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem Operator puts HDMI plug into HDMI_2 and then checks whether Notebook screen can be showed on monitor or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem cd ml_stress
@rem ./fpga_video_select.sh HDMI2
@rem ...wait for reboot...
@rem cd ml_stress
@rem ./stress_test.sh HDMI2 1khz
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Notebook with HDMI
@rem ===================

:START 
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\HDMI2.cmd
IF /I not #%HDMI2%#==#PASS# goto fail
GOTO PASS

:HDMI_Port2_Chk
msg.exe "请插入治具到待测机器HDMI Port 2接口！" 3 700 200 12
timeout 3
msg.exe "检查HDMI Port2显示器是否显示正常！" 3 700 200 12
echo *********************************
echo ****  Y(1).HDMI_Port2 Pass    ****
echo ****  N(0).HDMI_Port2 Fail    ****
echo ****  R(8).Retest HDMI_Port2  ****
echo *********************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto HDMI_Port2_Chk
if errorlevel 5 goto HDMI_Port2_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_HDMI_Port2_CheckLog.bat echo set HDMI_Port2=PASS
>>.\log\Test_HDMI_Port2_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg HDMI_Port2
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check HDMI Port 2 FAIL! ..................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check HDMI Port 2 FAIL!" 6 650 200 15
pause
color 07
goto end


:END