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
@rem 15W will be dissipated in the resistor for up to 5 seconds per test. MTP checks whether the dissipation meets the spec or not
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_test#./test_audio_spk.sh
@rem If "PASS, spk channel l working, power 15 W" is present on outputs, the test result is pass
@rem ===================

@rem Fixture Request:
@rem ===================
@rem 6R8 power resistor
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Write_FPGA_MAC.cmd
IF /I #%FPGA_MAC_ADDRESS%#==#%FPGA_MAC_FROM_SF%# goto pass
goto fail

:PASS
color 2f
>.\log\Test_Speaker_L_CheckLog.bat echo set Speaker_L=%FPGA_MAC_ADDRESS%
>>.\log\Test_Speaker_L_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Speaker_L
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............. Check Speaker_L FAIL! ..............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Speaker_L FAIL!" 6 650 200 15
pause
color 07
goto end


:END