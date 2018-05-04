@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    04/28/2018
@rem 1. For DVT build test fixture not ready, modify script for operator Manual Visual Inspection.
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem MTP tool sends a command in Linux shell prompt to turn on LED1to61~6 and then testing fixture reads LED1to6s status to check whether LED1to6s are working or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Fixture(Photoresistor)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\LED_red.cmd
CALL .\log\%tmSN%\result\LED_green.cmd
CALL .\log\%tmSN%\result\LED_both.cmd
IF /I #%LED_red%#==#FAIL# goto fail
IF /I #%LED_green%#==#FAIL# goto fail
IF /I #%LED_both%#==#FAIL# goto fail
goto pass


:LED1to6_Chk
timeout 3
msg.exe "检查LED1to6是否都有亮！" 3 700 200 12
echo **************************************
echo ****  Y(1).LED1to6 Pass    ****
echo ****  N(0).LED1to6 Fail    ****
echo ****  R(8).Retest LED1to6  ****
echo **************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto LED1to6_Chk
if errorlevel 5 goto LED1to6_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_LED1to6_CheckLog.bat echo set LED1to6=PASS
>>.\log\Test_LED1to6_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg LED1to6
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.................... Check LED1to6 FAIL! .................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check LED1to6 FAIL!" 6 650 200 15
pause
color 07
goto end


:END