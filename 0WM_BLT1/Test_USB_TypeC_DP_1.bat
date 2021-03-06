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
@rem MTP tool executes the script in Linux shell promptand then gets the test result.
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem /ml_utils#./firmware.sh bios
@rem (DVT BIOS version is on firmware.sh)
@rem ===================

@rem Fixture Request:
@rem ===================
@rem Notebook supports USB type-C with DisplayPort output
@rem ===================

:START 
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\DP1.cmd
IF /I not #%DP1%#==#PASS# goto fail
GOTO PASS

:USB_TypeC_DP_1_Chk
msg.exe "������ξߵ��������USB_TypeC_DP_1�ӿڣ�" 3 700 200 12
timeout 3
msg.exe "���USB_TypeC_DP_1��ʾ���Ƿ���ʾ������" 3 700 200 12
echo **************************************
echo ****  Y(1).USB_TypeC_DP_1 Pass    ****
echo ****  N(0).USB_TypeC_DP_1 Fail    ****
echo ****  R(8).Retest USB_TypeC_DP_1  ****
echo **************************************
choice /c:Y1N0R8 /N
if errorlevel 6 goto USB_TypeC_DP_1_Chk
if errorlevel 5 goto USB_TypeC_DP_1_Chk
if errorlevel 4 goto fail
if errorlevel 3 goto fail
goto Pass


:PASS
color 2f
>.\log\Test_USB_TypeC_DP_1_CheckLog.bat echo set USB_TypeC_DP_1=PASS
>>.\log\Test_USB_TypeC_DP_1_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg USB_TypeC_DP_1
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *............... Check USB_TypeC_DP_1 FAIL! ...............*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check USB_TypeC_DP_1 FAIL!" 6 650 200 15
pause
color 07
goto end


:END