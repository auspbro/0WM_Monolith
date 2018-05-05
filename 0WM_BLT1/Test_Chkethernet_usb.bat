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
@rem Using ethernet cable to connect RJ45_Port3 and RJ45_Port4, and then MTP tool checks whether the communication is working or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Ethernet Cable
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkUSB_eth_devices.cmd
IF /I not #%ChkUSB_eth_devices%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_Chkethernet_usb_CheckLog.bat echo set Chkethernet_usb=PASS
>>.\log\Test_Chkethernet_usb_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Chkethernet_usb
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *........ Check Chkethernet_usb FAIL! ..........*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Chkethernet_usb FAIL!" 6 650 200 15
pause
color 07
goto end


:END