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
@rem MTP tool writes Product module serial
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ml_smbios_read.sh  module_serial
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\WriteModuleSerial.cmd
IF /I #%WriteModuleSerial%#==#199# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_WriteProductModuleSerial_CheckLog.bat echo set WriteProductModuleSerial=%WriteModuleSerial%
>>.\log\Test_WriteProductModuleSerial_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg WriteProductModuleSerial
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.............. Write ProductModuleSerial FAIL! ...........*
ECHO *..........................................................*
ECHO ************************************************************
MSG "WriteProductModuleSerial FAIL!" 6 650 200 15
pause
color 07
goto end


:END