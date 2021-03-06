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
@rem i2cdetect -y 8
@rem Slave address: 0x4a, 0x4b
@rem ===================


:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkLMH1219.cmd
IF /I not #%ChkLMH1219%#==#1d# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_SDIReciver_LMH1219_CheckLog.bat echo set I2C_SDIReciver_LMH1219=%ChkLMH1219%
>>.\log\Test_I2C_SDIReciver_LMH1219_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_SDIReciver_LMH1219
cd..
goto end

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *..... Detect SDIReciver I2C FAIL! ........*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Detect SDIReciver I2C FAIL!" 6 750 200 15
pause
color 07
goto end


:END