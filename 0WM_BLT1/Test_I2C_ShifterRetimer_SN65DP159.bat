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
@rem MTP tool(Python) sends "i2cdetect" command in linux shell prompt to check whether the I2c chip is present or not. 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem i2cdetect -y 9 
@rem Slave address: 0x2c, 0x2e
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkSN65DP159.cmd
IF /I not #%ChkSN65DP159_1%#==#5b# GOTO FAIL
IF /I not #%ChkSN65DP159_2%#==#5c# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_ShifterRetimer_SN65DP159_CheckLog.bat echo set I2C_ShifterRetimer_SN65DP159=%ChkSN65DP159_1%_%ChkSN65DP159_2%
>>.\log\Test_I2C_ShifterRetimer_SN65DP159_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_ShifterRetimer_SN65DP159
cd..
goto end

:FAIL
color 4f
ECHO ****************************************************************************************
ECHO *......................................................................................*
ECHO *..... Detect AC-Coupled TMDS to HDMI Level Shifter Retimer(SN65DP159) I2C FAIL! ......*
ECHO *......................................................................................*
ECHO ****************************************************************************************
MSG "Detect AC-Coupled TMDS to HDMI Level Shifter Retimer(SN65DP159) I2C FAIL!" 6 1300 200 15
pause
color 07
goto end


:END