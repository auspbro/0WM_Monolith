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
@rem /ml_utils#./firmware.sh bios
@rem (DVT BIOS version is on firmware.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkBIOSVersion.cmd
IF /I #%ChkBIOSVersion%#==#PASS# goto pass
goto fail

:PASS
color 2f
>.\log\Test_CheckBIOSVer_CheckLog.bat echo set CheckBIOSVer=PASS
>>.\log\Test_CheckMAC_BT_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckBIOSVer
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check BIOS Version FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check BIOS Version FAIL!" 6 650 200 15
pause
color 07
goto end


:END