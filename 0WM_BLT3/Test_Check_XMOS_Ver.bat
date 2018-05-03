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
@rem MTP tool executes the script in Linux shell promptand then gets the test result.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ml_check_fw.sh DVT xmos
@rem (DVT xmos version is on ml_check_fw.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkXMOSVersion.cmd
IF /I #%ChkXMOSVersion%#==#PASS# goto pass
goto fail

:PASS
color 2f
>.\log\Test_Check_XMOS_Ver_CheckLog.bat echo set Check_XMOS_Ver=PASS
>>.\log\Test_Check_XMOS_Ver_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Check_XMOS_Ver
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............ Check Check_XMOS Version FAIL! ..............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Check_XMOS Version FAIL!" 6 650 200 15
pause
color 07
goto end


:END