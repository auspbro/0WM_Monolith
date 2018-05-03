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
@rem ====================
@rem EVT:
@rem modprobe -r bmc150_magn_i2c
@rem modprobe -r bmc150_accel_i2c
@rem i2cdetect -y 9
@rem Slave address: 0x10, 0x12
@rem modprobe bmc150_magn_i2c
@rem modprobe bmc150_accel_i2c
@rem DVT:
@rem modprobe -r ISM303DAC_magn_i2c
@rem modprobe -r ISM303DAC_accel_i2c
@rem i2cdetect -y 9
@rem Slave address: 0x1D, 0x1E
@rem modprobe ISM303DAC_magn_i2c
@rem modprobe ISM303DAC_accel_i2c
@rem ====================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkISM303DAC.cmd
IF /I not #%ECOMPASS%#==#12# GOTO FAIL
IF /I not #%ACCELEROMETER%#==#10# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_AccelSensor_ISM303DAC_CheckLog.bat echo set I2C_AccelSensor_ISM303DAC=%ACCELEROMETER%_%ECOMPASS%
>>.\log\Test_I2C_AccelSensor_ISM303DAC_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_AccelSensor_ISM303DAC
cd..
goto end

:FAIL
color 4f
ECHO ************************************************************************
ECHO *......................................................................*
ECHO *..... Detect ECOMPASS/ACCELEROMETER Sensor(ISM303DAC) I2C FAIL! ......*
ECHO *......................................................................*
ECHO ************************************************************************
MSG "Detect ECOMPASS/ACCELEROMETER Sensor(ISM303DAC) I2C FAIL!" 6 1200 200 15
pause
color 07
goto end


:END