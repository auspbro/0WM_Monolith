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
@rem MTP tool reads MAC Address of FPGA and check the MAC is correct or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./mac_read.sh fpga 
@rem ===================

:Get_MAC_From_SF
if exist .\log\MAC_Response.bat del .\log\MAC_Response.bat
call sdtGetDataFromSF.exe Mac %tmSN% > .\log\MAC_Response.bat
call .\log\MAC_Response.bat

:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\Write_FPGA_MAC.cmd
IF /I #%FPGA_MAC_ADDRESS%#==#%FPGA_MAC_FROM_SF%# goto pass
goto fail

:PASS
color 2f
>.\log\Test_CheckMAC_FPGA_CheckLog.bat echo set CheckMAC_FPGA=%FPGA_MAC_ADDRESS%
>>.\log\Test_CheckMAC_FPGA_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg CheckMAC_FPGA
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check MAC FPGA FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check MAC FPGA FAIL!" 6 650 200 15
pause
color 07
goto end


:END