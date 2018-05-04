@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    05/04/2018
@rem 1. Skip this test item for DVT build.
@rem 2. FB customer hardware or image Not ready.
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem Operator puts DisplayPort plug into DP_HDMI_Port_2 and then check whether DisplayPort with HDMI is working or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem no
@rem ===================

:skip_for_dvt
goto pass

:START
CALL .\Process\DVSN.BAT

:DP_HDMI_Port_2_Chk
msg.exe "请插入治具到待测机器DP to HDMI Port 2接口！" 3 700 200 12
timeout 3
msg.exe "检查DP to HDMI Port2显示器是否显示正常！" 3 700 200 12
echo ***************************************
echo ****   Y(1).DP_HDMI_Port_2 Pass    ****
echo ****   N(0).DP_HDMI_Port_2 Fail    ****
echo ****   R(8).Retest DP_HDMI_Port_2  ****
echo ***************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto DP_HDMI_Port_2_Chk
if errorlevel 5 goto DP_HDMI_Port_2_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass


:PASS
color 2f
>.\log\Test_DP_HDMI_Port2_CheckLog.bat echo set DP_HDMI_Port2=PASS
>>.\log\Test_DP_HDMI_Port2_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg DP_HDMI_Port2
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.............. Check DP_HDMI_Port_2 FAIL! ................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check DP_HDMI_Port_2 FAIL!" 6 650 200 15
pause
color 07
goto end


:END