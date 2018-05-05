@echo on

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    05/03/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    04/28/2018
@rem 1. 
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem call python script start test
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem No
@rem ===================

:DebugMode
CALL .\Process\DVSN.BAT
if not %tmSN%==A1234567890 goto Get_MAC_From_SF
set MAC_WGI210=00:a0:c9:00:00:00
set MAC_FPGA=11:a0:c9:00:00:00
GOTO StartPythonGUI


:Get_MAC_From_SF
if exist .\log\MAC_Response.bat del .\log\MAC_Response.bat
call sdtGetDataFromSF.exe Mac %tmSN% > .\log\MAC_Response.bat
call .\log\MAC_Response.bat

:StartPythonGUI
CALL .\Process\DVSN.BAT
cd .\BU1_0WM
python gui_runner_MB.py %tmSN% %MAC_WGI210% %MAC_FPGA%
goto pass

:pass
cd ..
cd c:\TestProgram\0WM\0WM_BLT1\Process
>..\log\Test_start_log.bat echo set Test_start=PASS
>>..\log\Test_start_log.bat echo set TestResult=PASS
copy ..\log\Test_start_log.bat ..\logtmp /y
call sdtCheckLog.exe Model_MLBTEST.cfg Test_start
goto end

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *...................... Test FAIL! ........................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Test FAIL!" 6 650 200 15
pause
color 07
goto end

:end