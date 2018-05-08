@echo on
rem **************************************************************
rem                       Change History
rem Rev. 3A  2015/02/03 Liuping
rem    1.Release for Testmonitor 0WM use
rem 
rem ...............................................................
c:
cd C:\TestProgram\0WM\0WM_SLT1

call GetLocalTime.exe
call GetLocalTime.bat
copy C:\TestProgram\0WM\0WM_SLT1\Process\DVSN.BAT /Y
>>DVSN.BAT echo set LeeDate=%LeeDate%
>>DVSN.BAT echo set LeeTime=%LeeTime%
call C:\TestProgram\0WM\0WM_SLT1\DVSN.BAT

:Link_SF_Log_Server
set MSG=Link_SF_Log_Server
set maptimes=5

:ReLink_SF_Log_Server
if exist m:\ goto Creat_Logfile

net use m: \\172.26.6.72\NB1 qmsswdl /user:nb1
if exist m:\ goto Creat_Logfile
timeout 2
set /a maptimes-=1
if #%maptimes%#==#0# goto fail
goto ReLink_SF_Log_Server

:Creat_Logfile
if exist m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID% (
	cd /d m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto Creat_Processfile
)
timeout 1
md m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto Creat_Processfile
)
timeout 1
md m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\Log\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto Creat_Processfile
)

goto fail

:Creat_Processfile
if exist m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID% (
	cd /d m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto SLT1_Start_Test
)
timeout 1
md m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto SLT1_Start_Test
)
timeout 1
md m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\Process\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%
	if not errorlevel 1 goto SLT1_Start_Test
)

goto fail

:SLT1_Start_Test
cd /d C:\TestProgram\0WM\0WM_SLT1

:pass
goto end

:fail
color 4e
start /b msg.exe %MSG%_FAIL! 120 1000 300 30
goto end


:end







