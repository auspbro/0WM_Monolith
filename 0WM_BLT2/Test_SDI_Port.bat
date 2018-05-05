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
@rem Operator puts SDI plug into SDI and then checks whether Notebook screen can be showed on monitor or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_stress#./fpga_video_select.sh SDI
@rem ...wait for reboot...
@rem /ml_stress#./stress_test.sh SDI 1khz
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Notebook with HDMI+HMDI to SDI Converter
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\SDI.cmd
IF /I not #%SDI%#==#PASS# GOTO fail
goto PASS

:SDI_Port_Chk
msg.exe "请插入治具到待测机器SDI Port接口！" 3 700 200 12
timeout 3
msg.exe "检查SDI Port显示器是否显示正常！" 3 700 200 12
echo *********************************
echo ****  Y(1).SDI_Port Pass    ****
echo ****  N(0).SDI_Port Fail    ****
echo ****  R(8).Retest SDI_Port  ****
echo *********************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto SDI_Port_Chk
if errorlevel 5 goto SDI_Port_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass


:PASS
color 2f
>.\log\Test_SDI_Port_CheckLog.bat echo set SDI_Port=PASS
>>.\log\Test_SDI_Port_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg SDI_Port
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check SDI Port1 FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check SDI Port1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END