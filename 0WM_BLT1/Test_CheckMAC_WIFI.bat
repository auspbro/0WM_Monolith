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
@rem MTP tool reads WIFI MAC Address and then records on SF server
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem cd ml_utils
@rem ./mac_read.sh wlan
@rem (cat /sys/class/net/wlan0/address)
@rem ===================

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ReadWIFI-Mac.cmd
IF /I #%ReadWIFI-Mac%#==#00:00:00:00:00:00# goto fail
IF /I #%ReadWIFI-Mac%#==#FF:FF:FF:FF:FF:FF# goto fail
goto pass

:PASS
color 2f
>.\log\Test_CheckMAC_WIFI_CheckLog.bat echo set CheckMAC_WIFI=%ReadWIFI-Mac%
>>.\log\Test_CheckMAC_WIFI_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckMAC_WIFI
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check MAC WIFI FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check MAC WIFI FAIL!" 6 650 200 15
pause
color 07
goto end


:END