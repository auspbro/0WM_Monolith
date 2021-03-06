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
@rem 1. MTP tool writes MAC Address of INTEL WGI210-AT
@rem 2. The MAC is set by manufacturer
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_write.sh i210 00:a0:c9:00:00:00
@rem ===================

REM :Get_MAC_From_SF
REM if exist .\log\MAC_Response.bat del .\log\MAC_Response.bat
REM call sdtGetDataFromSF.exe Mac %tmSN% > .\log\MAC_Response.bat
REM call .\log\MAC_Response.bat

:DebugMode
CALL .\Process\DVSN.BAT
if not %tmSN%==A1234567890 goto START
set WriteMAC_WGI210=ABCDEFGHIJKL
GOTO PASS


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\WriteMacWGI210.cmd
IF /I #%WriteMacWGI210%#==#PASS# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_WriteMAC_WGI210_CheckLog.bat echo set WriteMAC_WGI210=PASS
>>.\log\Test_WriteMAC_WGI210_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg WriteMAC_WGI210
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write MAC WGI210 FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write MAC WGI210 FAIL!" 6 650 200 15
pause
color 07
goto end


:END