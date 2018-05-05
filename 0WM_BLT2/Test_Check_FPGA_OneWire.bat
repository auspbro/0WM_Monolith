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
@rem MTP tool sends "lspci" command in linux shell prompt to check whether the FPGA is present or not 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem lspci
@rem (04:00.0 Multimedia controller: Device 1aa3:0011)
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkFPGA-OneWire.cmd
IF /I not #%ChkFPGA-OneWire%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_Check_FPGA_OneWire_CheckLog.bat echo set Check_FPGA_OneWire=%ChkFPGA-OneWire%
>>.\log\Test_Check_FPGA_OneWire_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg Check_FPGA_OneWire
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............ Check  FPGA OneWire FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check FPGA OneWire FAIL!" 6 650 200 15
pause
color 07
goto end


:END