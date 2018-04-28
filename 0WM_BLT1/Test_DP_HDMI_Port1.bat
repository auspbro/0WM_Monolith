@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    04/28/2018
@rem 1. Add testing procedure & Linux command for easy maintain or debug later. 
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem Operator puts DisplayPort plug into DP_HDMI_Port_1 and then check whether DisplayPort with HDMI is working or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem no
@rem ===================

:START
CALL .\Process\DVSN.BAT


:DP_HDMI_Port_1_Chk
msg.exe "请插入治具到待测机器DP to HDMI Port 1接口！" 3 700 200 12
timeout 3
msg.exe "检查DP to HDMI Port1显示器是否显示正常！" 3 700 200 12
echo ***************************************
echo ****   Y(1).DP_HDMI_Port_1 Pass    ****
echo ****   N(0).DP_HDMI_Port_1 Fail    ****
echo ****   R(8).Retest DP_HDMI_Port_1  ****
echo ***************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto DP_HDMI_Port_1_Chk
if errorlevel 5 goto DP_HDMI_Port_1_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_DP_HDMI_Port_1_CheckLog.bat echo set DP_HDMI_Port_1=PASS
>>.\log\Test_DP_HDMI_Port_1_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg DP_HDMI_Port_1
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............... Check DP_HDMI_Port_1 FAIL! ...............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check DP_HDMI_Port_1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END