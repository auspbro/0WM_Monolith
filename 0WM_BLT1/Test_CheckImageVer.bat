@echo oN

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
@rem MTP tool sends a command in Linux shell prompt to read image version back and then check whether the version is correct or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

:skip_for_dvt
set Image_Version=SKIP
goto pass

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Image_Version.cmd
IF /I #%Image_Version%#==#XXX# goto fail
goto pass

:PASS
color 2f
>.\log\Test_CheckImageVer_CheckLog.bat echo set CheckImageVer=%Image_Version%
>>.\log\Test_CheckImageVer_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckImageVer
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check Image Version FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Image Version FAIL!" 6 650 200 15
pause
color 07
goto end


:END