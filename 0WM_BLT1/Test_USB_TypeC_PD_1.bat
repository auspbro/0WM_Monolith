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
@rem Operator puts USB Type-C plug into USB_TypeC_1 and then checks whether Notebook is charging or not.
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
call .\log\%tmSN%\result\ChkPowerDeliveryDP1.cmd
IF /I not #%ChkPowerDeliveryDP1%#==#PASS# GOTO FAIL
goto pass


:USB_TypeC_PD_1_Chk
msg.exe "请插入治具到待测机器USB_TypeC_PD_1接口！" 3 700 200 12
timeout 3
msg.exe "检查USB_TypeC_PD_1显示器是否显示正常！" 3 700 200 12
echo **************************************
echo ****  Y(1).USB_TypeC_PD_1 Pass    ****
echo ****  N(0).USB_TypeC_PD_1 Fail    ****
echo ****  R(8).Retest USB_TypeC_PD_1  ****
echo **************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto USB_TypeC_PD_1_Chk
if errorlevel 5 goto USB_TypeC_PD_1_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass

:PASS
color 2f
>.\log\Test_USB_TypeC_PD_1_CheckLog.bat echo set USB_TypeC_PD_1=PASS
>>.\log\Test_USB_TypeC_PD_1_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg USB_TypeC_PD_1
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check USB_TypeC_PD_1 FAIL! .............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check USB_TypeC_PD_1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END