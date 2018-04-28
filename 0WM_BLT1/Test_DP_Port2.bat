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
@rem Operator puts DisplayPort plug into DP_Port_1 and then check whether DisplayPort is working or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem no
@rem ===================

:START
CALL .\Process\DVSN.BAT

:DP_Port_2_Chk
msg.exe "请插入治具到待测机器DP Port 2接口！" 3 700 200 12
timeout 3
msg.exe "检查DP Port2显示器是否显示正常！" 3 700 200 12
echo *********************************
echo ****  Y(1).DP_Port_2 Pass    ****
echo ****  N(0).DP_Port_2 Fail    ****
echo ****  R(8).Retest DP_Port_2  ****
echo *********************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto DP_Port_2_Chk
if errorlevel 5 goto DP_Port_2_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_DP_Port_2_CheckLog.bat echo set DP_Port_2=%BT_MAC_ADDRESS%
>>.\log\Test_DP_Port_2_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg DP_Port_2
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check DP Port 2 FAIL! ..................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check DP Port 2 FAIL!" 6 650 200 15
pause
color 07
goto end


:END