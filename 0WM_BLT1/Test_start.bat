:Test_start
c:
cd c:\TestProgram\0WM\0WM_BLT1
RS232.exe poweroff 1000 A3
timeout 1
RS232.exe poweron 1000 A0
timeout 2

:Start
set testcycle=0

:VoltageTest
if exist c:\TestProgram\0WM\0WM_BLT1\log\Voltage.bat del c:\TestProgram\0WM\0WM_BLT1\log\Voltage.bat
RS232.exe Voltage 1000 A1 >c:\TestProgram\0WM\0WM_BLT1\log\Voltage.bat
ping 1.1.1.1 -n 1 -w 500 >nul
if not exist c:\TestProgram\0WM\0WM_BLT1\log\Voltage.bat goto end
call c:\TestProgram\0WM\0WM_BLT1\log\Voltage.bat
if %TP348_3V3%==0.00 goto again
if #%TP348_3V3%#==## goto again
if #%TP348_3V3%#==# # goto again
if #%TP348_3V3%#==#  # goto again
if #%TP348_3V3%#==#   # goto again
if #%TP348_3V3%#==#    # goto again
goto pass

:again
set /a testcycle=%testcycle%+1
if "%testcycle%"=="5" goto fail
goto VoltageTest

:pass
cd c:\TestProgram\0WM\0WM_BLT1\Process
>..\log\Test_start_log.bat echo set Test_start=PASS
>>..\log\Test_start_log.bat echo set TestResult=PASS
copy ..\log\Test_start_log.bat ..\logtmp /y
call sdtCheckLog.exe Model_MLBTEST.cfg Test_start
goto end

:fail
c:
cd c:\TestProgram\0WM\0WM_BLT1
RS232.exe poweroff 1000 A3
ECHO .****** TEST Voltage FAIL! *******
MSG "TEST Voltage FAIL!" 10 500 200 15
GOTO END

:end