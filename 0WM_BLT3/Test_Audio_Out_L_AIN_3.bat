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
@rem 1.Audio_out_l(Playback)>>MIC_Line_3(Recording)
@rem 2.MTP checks whether sound is audible or not 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_test#./test_audio_line.sh
@rem If "PASS, signal from xmos_line_3_48k_32bit on input mic_line_3_48k_32bit" is present on outputs, the test result is pass.
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Audio lineout out linein loopback cable
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Write_FPGA_MAC.cmd
IF /I #%FPGA_MAC_ADDRESS%#==#%FPGA_MAC_FROM_SF%# goto pass
goto fail

:PASS
color 2f
>.\log\Test_Audio_Out_L_AIN_3_CheckLog.bat echo set Audio_Out_L_AIN_3=%FPGA_MAC_ADDRESS%
>>.\log\Test_Audio_Out_L_AIN_3_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Audio_Out_L_AIN_3
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............. Check Audio_Out_L_AIN_3 FAIL! ..............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check Audio_Out_L_AIN_3 FAIL!" 6 650 200 15
pause
color 07
goto end


:END