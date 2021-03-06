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
@rem /ml_utils#./firmware.sh usb_c_1
@rem /ml_utils#./firmware.sh usb_c_2
@rem (DVT TypeC version is on firmware.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkUSBTypeCVersion1.cmd
CALL .\log\%tmSN%\result\ChkUSBTypeCVersion2.cmd
IF /I #%ChkUSBTypeCVersion1%#==#PASS# IF /I #%ChkUSBTypeCVersion2%#==#PASS# goto PASS
goto FAIL

:PASS
color 2f
>.\log\Test_CheckUSBTypeCFWVer_CheckLog.bat echo set CheckUSBTypeCFWVer=PASS
>>.\log\Test_CheckUSBTypeCFWVer_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckUSBTypeCFWVer
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check USB Type-C Version FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check USB Type-C Version FAIL!" 6 650 200 15
pause
color 07
goto end


:END