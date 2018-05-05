@echo oN

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    05/04/2018
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem MTP tool sends a command in Linux shell prompt to read image version back and then check whether the version is correct or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkCPUInfo.cmd
CALL .\log\%tmSN%\result\ChkDDRSpeed.cmd
CALL .\log\%tmSN%\result\ChkDDRSize.cmd
CALL .\log\%tmSN%\result\ChkEMMCName.cmd
CALL .\log\%tmSN%\result\ChkEMMCSize.cmd
CALL .\log\%tmSN%\result\ChkSSDName.cmd
CALL .\log\%tmSN%\result\ChkSSDSize.cmd
IF /I not #%ChkCPUInfo%#==#PASS# goto fail
IF /I not #%ChkDDRSpeed%#==#PASS# goto fail
IF /I not #%ChkDDRSize%#==#PASS# goto fail
IF /I not #%ChkEMMCName%#==#PASS# goto fail
IF /I not #%ChkEMMCSize%#==#PASS# goto fail
IF /I not #%ChkSSDName%#==#PASS# goto fail
IF /I not #%ChkSSDSize%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_SysInfo_CheckLog.bat echo set SysInfo=PASS
>>.\log\Test_SysInfo_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg SysInfo
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check SysInfo FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check SysInfo FAIL!" 6 650 200 15
pause
color 07
goto end


:END