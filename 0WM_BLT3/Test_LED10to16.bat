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
@rem MTP tool sends a command in Linux shell prompt to turn on LED10~16 and then testing fixture reads LEDs status to check whether LEDs are working or not.
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

:LED10to16_Chk
timeout 3
msg.exe "检查LED10to16是否都有亮！" 3 700 200 12
echo **************************************
echo ****  Y(1).LED10to16 Pass    ****
echo ****  N(0).LED10to16 Fail    ****
echo ****  R(8).Retest LED10to16  ****
echo **************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto LED10to16_Chk
if errorlevel 5 goto LED10to16_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_LED10to16_CheckLog.bat echo set LED10to16=PASS
>>.\log\Test_LED10to16_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg LED10to16
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.................... Check LED10to16 FAIL! .....................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check LED10to16 FAIL!" 6 650 200 15
pause
color 07
goto end


:END