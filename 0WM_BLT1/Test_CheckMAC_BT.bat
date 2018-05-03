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
@rem MTP tool reads BT MAC Address and then records on SF server
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_read.sh bluetooth
@rem (hciconfig hci0 | grep "BD Address:")
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ReadBT-Mac.cmd
IF /I #%ReadBT-Mac%#==#00:00:00:00:00:00# goto fail
IF /I #%ReadBT-Mac%#==#FF:FF:FF:FF:FF:FF# goto fail
goto pass

:PASS
color 2f
>.\log\Test_CheckMAC_BT_CheckLog.bat echo set CheckMAC_BT=%ReadBT-Mac%
>>.\log\Test_CheckMAC_BT_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckMAC_BT
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check MAC BT FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check MAC BT FAIL!" 6 650 200 15
pause
color 07
goto end


:END