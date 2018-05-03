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
@rem MTP tool reads Product Name and check if it is correct or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem Currently new value will be applied after reboot.
@rem /ml_utils#./smbios_read.sh product
@rem (Product name(MONOLITH) is defined on smbios_Check.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ReadPN.cmd
IF /I #%ReadPN%#==#MONOLITH# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_CheckProductName_CheckLog.bat echo set CheckProductName=%ReadPN%
>>.\log\Test_CheckProductName_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckProductName
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check Product Name FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Product Name FAIL!" 6 650 200 15
pause
color 07
goto end


:END