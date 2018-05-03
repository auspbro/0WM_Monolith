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
@rem Operator puts USB3.0 Storage into USB_TypeA_1 and then MTP tool checks whether USB3.0 storage can be supported or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem lsusb -t
@rem ===================


:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkUSB_TypeA_1.cmd
IF /I #%ChkUSB_TypeA_1%#==#5000M# GOTO PASS
goto FAIL


:PASS
color 2f
>.\log\Test_USB_TypeA_1_CheckLog.bat echo set USB_TypeA_1=PASS
>>.\log\Test_USB_TypeA_1_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg USB_TypeA_1
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check USB_TypeA_1 FAIL! ................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check USB_TypeA_1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END