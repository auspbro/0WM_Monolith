@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    05/04/2018
@rem 1. Skip this test item for DVT build.
@rem 2. FB customer program Not ready.
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem MTP tool sends a command in Linux shell prompt to turn on LED7~9 and then testing fixture reads LEDs status to check whether LEDs are working or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Fixture(Photoresistor)
@rem ===================

:skip_for_dvt
goto pass

:START
CALL .\Process\DVSN.BAT

:LED7to9_Chk
timeout 3
msg.exe "检查LED7to9是否都有亮！" 3 700 200 12
echo **************************************
echo ****  Y(1).LED7to9 Pass    ****
echo ****  N(0).LED7to9 Fail    ****
echo ****  R(8).Retest LED7to9  ****
echo **************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto LED7to9_Chk
if errorlevel 5 goto LED7to9_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_LED7to9_CheckLog.bat echo set LED7to9=PASS
>>.\log\Test_LED7to9_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg LED7to9
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.................... Check LED7to9 FAIL! .....................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check LED7to9 FAIL!" 6 650 200 15
pause
color 07
goto end


:END