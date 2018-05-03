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
@rem The MAC is set by module, just copy to eeprom
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_write.sh bluetooth
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\WriteMacBT.cmd
IF /I #%WriteMacBT%#==#[['79']]# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_WriteMAC_BT_CheckLog.bat echo set WriteMAC_BT=%WriteMacBT%
>>.\log\Test_WriteMAC_BT_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg WriteMAC_BT
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write BT MAC FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write BT MAC FAIL!" 6 650 200 15
pause
color 07
goto end


:END