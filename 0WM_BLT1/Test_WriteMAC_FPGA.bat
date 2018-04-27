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
@rem 1. MTP tool writes MAC Address of FPGA.
@rem 2. The MAC is set by manufacturer, only stored in eeprom
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_write.sh fpga 11:22:33:44:55:66
@rem ===================

:Get_MAC_From_SF
if exist .\log\MAC_Response.bat del .\log\MAC_Response.bat
call sdtGetDataFromSF.exe Mac %tmSN% > .\log\MAC_Response.bat
call .\log\MAC_Response.bat

:START
CALL .\Process\DVSN.BAT
python FPGA_MAC %FPGA_MAC%
CALL .\log\%tmSN%\result\Write_FPGA_MAC.cmd
IF /I #%Write_FPGA_MAC%#==#PASS# GOTO PASS
GOTO FAIL

:PASS
color 2f
>.\log\Test_WriteMAC_FPGA_CheckLog.bat echo set WriteMAC_FPGA=PASS
>>.\log\Test_WriteMAC_FPGA_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg WriteMAC_FPGA
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Write MAC FPGA FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Write MAC FPGA FAIL!" 6 650 200 15
pause
color 07
goto end


:END