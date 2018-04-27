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
@rem MTP tool writes Product Name
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./smbios_write.sh product
@rem (Product name(MONOLITH) is defined on smbios_write.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\WRITE_Product_Name.cmd
IF /I #%WRITE_Product_Name%#==#PASS# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_WriteProductName_CheckLog.bat echo set WriteProductName=PASS
>>.\log\Test_WriteProductName_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg WriteProductName
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write Product Name FAIL! ...............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write Product Name FAIL!" 6 650 200 15
pause
color 07
goto end


:END