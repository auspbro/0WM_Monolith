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
@rem MTP tool reads Product Version and check if it is correct or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem Currently new value will be applied after reboot.
@rem /ml_utils#./smbios_read.sh version
@rem (Product Version(0.2X) is defined on smbios_write.sh)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Check_Product_Version.cmd
IF /I #%Check_Product_Version%#==#PASS# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_CheckProductVersion_CheckLog.bat echo set CheckProductVersion=PASS
>>.\log\Test_CheckProductVersion_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckProductVersion
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write Product Version FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write Product Version FAIL!" 6 650 200 15
pause
color 07
goto end


:END