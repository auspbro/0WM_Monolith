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
@rem MTP tool reads Product UUID and check if it is present or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem Currently new value will be applied after reboot.
@rem /ml_utils#./smbios_read.sh uuid
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Check_Product_UUD.cmd
IF /I #%Check_Product_UUD%#==#FAIL# GOTO FAIL
IF /I #%Product_UUD%#==#%%# GOTO FAIL
GOTO FAIL

:PASS
color 2f
>.\log\Test_Test_CheckProductUUID_CheckLog.bat echo set Test_CheckProductUUID=PASS
>>.\log\Test_Test_CheckProductUUID_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Test_CheckProductUUID
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write BT MAC FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write BT MAC FAIL!" 6 650 200 15
pause
color 07
goto end


:END