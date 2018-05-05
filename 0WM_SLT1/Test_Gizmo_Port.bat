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
@rem Using ethernet cable to connects between 0WM and QF7 and then MTP tool checks whether POE is working or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Gizmo(QF7)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkGizmoPort.cmd
IF /I not #%ChkGizmoPort%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_Gizmo_Port_CheckLog.bat echo set Gizmo_Port=PASS
>>.\log\Test_Gizmo_Port_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Gizmo_Port
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check Gizmo_Port FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Gizmo_Port FAIL!" 6 650 200 15
pause
color 07
goto end


:END