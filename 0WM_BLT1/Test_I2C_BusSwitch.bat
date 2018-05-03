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
@rem #enable the SMI mux so EEPROM sits on i2c
@rem isaset -y -f 0x29f 0x80
@rem #check device is present
@rem i2cdetect -y 10 | grep 50
@rem #set SMI mux back to Realtek
@rem isaset -y -f 0x29f 0x00
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\ChkSN74CB3Q3306APWR.cmd
IF /I not #%ChkSN74CB3Q3306APWR%#==#50# GOTO FAIL
goto pass

:PASS
color 2f
>.\log\Test_I2C_BusSwitch_CheckLog.bat echo set I2C_BusSwitch=%ChkSN74CB3Q3306APWR%
>>.\log\Test_I2C_BusSwitch_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg I2C_BusSwitch
cd..
goto end

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............... Detect BusSwitch I2C FAIL! ..................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Detect BusSwitch I2C FAIL!" 6 650 200 15
pause
color 07
goto end


:END