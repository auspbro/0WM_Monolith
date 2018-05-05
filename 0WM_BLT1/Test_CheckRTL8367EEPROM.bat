@echo off

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    05/04/2018
@rem 1. Add script to check if UUID is 32 bit lenth.
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
setlocal EnableDelayedExpansion 
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkRTL8367EEPROM.cmd
IF /I not #%ChkRTL8367EEPROM%#==#PASS# goto fail
GOTO PASS


:PASS
color 2f
>.\log\Test_CheckRTL8367EEPROM_CheckLog.bat echo set CheckRTL8367EEPROM=PASS
>>.\log\Test_CheckRTL8367EEPROM_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckRTL8367EEPROM
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *.................CheckRTL8367EEPROM FAIL! ................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check CheckRTL8367EEPROM FAIL!" 6 650 200 15
pause
color 07
goto end


:END