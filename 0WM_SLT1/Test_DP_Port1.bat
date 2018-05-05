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
@rem No
@rem ===================

:START 
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkDP1.cmd
IF /I not #%ChkDP1%#==#PASS# goto fail
GOTO PASS


:DP_Port_1_Chk
msg.exe "������ξߵ��������DP Port 1�ӿڣ�" 3 700 200 12
timeout 3
msg.exe "���DP Port1��ʾ���Ƿ���ʾ������" 3 700 200 12
echo *********************************
echo ****  Y(1).DP_Port_1 Pass    ****
echo ****  N(0).DP_Port_1 Fail    ****
echo ****  R(8).Retest DP_Port_1  ****
echo *********************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto DP_Port_1_Chk
if errorlevel 5 goto DP_Port_1_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass


:PASS
color 2f
>.\log\Test_DP_Port1_CheckLog.bat echo set DP_Port1=PASS
>>.\log\Test_DP_Port1_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg DP_Port1
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check DP Port1 FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check DP Port1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END