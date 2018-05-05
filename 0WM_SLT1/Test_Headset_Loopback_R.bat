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
@rem MTP checks whether sound is audible or not 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem 1. arecord -f S32_LE -r 48000 -d 2 -D head_mic_48k_32bit headset.wav
@rem 2. aplay -q -c 2 -f S32_LE -r 48000 -D xmos_head_r_48k_32bit headset.wav
@rem ===================

@rem Fixture Request:
@rem ===================
@rem headset Loopback cable
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Headset_Loopback_R.cmd
IF /I #%Headset_Loopback_R%#==#PASS# goto pass
goto fail

:PASS
color 2f
>.\log\Test_Headset_Loopback_R_CheckLog.bat echo set Headset_Loopback_R=PASS
>>.\log\Test_Headset_Loopback_R_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Headset_Loopback_R
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............. Check Headset_Loopback_R FAIL! ..............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Headset_Loopback_R FAIL!" 6 650 200 15
pause
color 07
goto end


:END