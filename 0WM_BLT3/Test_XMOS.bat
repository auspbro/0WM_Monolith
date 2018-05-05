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
@rem MTP tool(Python) sends "lsusb" command in linux shell prompt to check whether XMOS is present or not 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem lsusb
@rem ===================

:StartPythonGUI
CALL .\Process\DVSN.BAT
cd .\BU1_0WM
python gui_runner_audio.py %tmSN%
cd ..
goto START

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkXMOS.cmd
CALL .\log\%tmSN%\result\ChkXMOS-test.cmd
IF /I not #%ChkXMOS%#==#PASS# goto fail
IF /I not #%ChkXMOS-test%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_XMOS_CheckLog.bat echo set XMOS=PASS
>>.\log\Test_XMOS_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg XMOS
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *....................... Check XMOS FAIL! .................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check XMOS FAIL!" 6 650 200 15
pause
color 07
goto end


:END