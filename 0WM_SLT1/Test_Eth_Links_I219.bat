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
@rem Using USB 3.0 TypeA Male to RJ45 Female Gigabit Ethernet Network Adapter with Ethernet Cable to connect between USB_TypeA_2 and RJ45_2 and then MTP tool checks whether the communication is working or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================

@rem Fixture Request:
@rem ===================
@rem USB 3.0 TypeA Male to RJ45 Female Gigabit Ethernet Network Adapter with Ethernet Cable
@rem ===================


:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\Chkethernet_I219.cmd
IF /I not #%Chkethernet_I219%#==#PASS# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_Eth_Links_I219_CheckLog.bat echo set Eth_Links_I219=PASS
>>.\log\Test_Eth_Links_I219_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Eth_Links_I219
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............ Check Eth_Links_I219 FAIL! ..............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Eth_Links_I219 FAIL!" 6 650 200 15
pause
color 07
goto end


:END