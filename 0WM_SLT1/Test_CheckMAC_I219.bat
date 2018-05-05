@echo on

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
@rem MTP tool reads MAC Address of I219-LM and then records on SF server
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_read.sh i219
@rem (cat /sys/class/net/eth1/address)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ReadI219LM-Mac.cmd
IF /I #%ReadI219LM-Mac%#==#00:00:00:00:00:00# goto fail
IF /I #%ReadI219LM-Mac%#==#FF:FF:FF:FF:FF:FF# goto fail
goto pass

:PASS
color 2f
>.\log\Test_CheckMAC_I219_CheckLog.bat echo set CheckMAC_I219=%ReadI219LM-Mac%
>>.\log\Test_CheckMAC_I219_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckMAC_I219
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check MAC I219 FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check MAC I219 FAIL!" 6 650 200 15
pause
color 07
goto end


:END