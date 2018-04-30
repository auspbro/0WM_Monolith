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
@rem MTP tool sends "isaset" command in Linux shell prompt to enable the SIM mux and then sends "i2cdetect" to check whether the I2c chip is present or not 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem i2cdetect -y 7
@rem Slave address: 0x77
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\i2cdetect.cmd
IF /I #%Si5340%#==#FAIL# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_ClockGenerator_si5340_CheckLog.bat echo set I2C_ClockGenerator_si5340=PASS
>>.\log\Test_I2C_ClockGenerator_si5340_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_ClockGenerator_si5340
cd..
goto end

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *........ Detect I2C_ClockGenerator_si5340 FAIL! ..........*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Detect ClockGenerator I2C FAIL!" 6 650 200 15
pause
color 07
goto end


:END