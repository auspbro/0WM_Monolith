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
@rem modprobe -r ina2xx
@rem i2cdetect -y 10
@rem Slave address:0x40, 0x41, 0x42, 0x43, 0x44
@rem modprobe ina2xx
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkINA230.cmd
IF not #%ChkINA230_1%#==#40# GOTO FAIL
IF not #%ChkINA230_2%#==#41# GOTO FAIL
IF not #%ChkINA230_3%#==#42# GOTO FAIL
IF not #%ChkINA230_4%#==#43# GOTO FAIL
IF not #%ChkINA230_5%#==#44# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_PowerMonitor_INA230_CheckLog.bat echo set I2C_PowerMonitor_INA230=%ChkINA230_1%_%ChkINA230_2%_%ChkINA230_3%_%ChkINA230_4%_%ChkINA230_5%
>>.\log\Test_I2C_PowerMonitor_INA230_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_PowerMonitor_INA230
cd..
goto end

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *..... Detect Current/Power Monitor(INA30) I2C FAIL! ......*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Detect Power Monitor(INA30) I2C FAIL!" 6 650 200 15
pause
color 07
goto end


:END