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
@rem Operator puts USB Type-C plug into USB_TypeC_1 and then checks whether Notebook screen can be showed on monitor or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_stress#./fpga_video_select.sh DP1
@rem ...wait for reboot...
@rem /ml_stress#./stress_test.sh DP1 1khz
@rem ===================


:START 
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkDP2.cmd
IF /I not #%ChkDP2%#==#PASS# goto fail
GOTO PASS

:DP_Port_2_Chk
msg.exe "������ξߵ��������DP Port 2�ӿڣ�" 3 700 200 12
timeout 3
msg.exe "���DP Port2��ʾ���Ƿ���ʾ������" 3 700 200 12
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
>.\log\Test_DP_Port2_CheckLog.bat echo set DP_Port2=PASS
>>.\log\Test_DP_Port2_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg DP_Port2
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