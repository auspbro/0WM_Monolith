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
@rem Operator puts USB Type-C plug into USB_TypeC_2 and then checks whether Notebook is charging or not.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem No
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Notebook supports USB type-C with DisplayPort output
@rem ===================

:START
call .\Process\DVSN.BAT
call .\log\%tmSN%\result\PCIE_test_Result.cmd
IF /I not #%PCIE_test_Result%#==#PASS# GOTO FAIL
goto pass


:PASS
color 2f
>.\log\Test_PCIEx4_Loopback_CheckLog.bat echo set PCIEx4_Loopback=PASS
>>.\log\Test_PCIEx4_Loopback_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg PCIEx4_Loopback
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check PCIEx4_Loopback FAIL! .............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check PCIEx4_Loopback FAIL!" 6 650 200 15
pause
color 07
goto end


:END