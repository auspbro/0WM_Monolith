@echo off
:LinkServer
call GetLocalTime.exe
call GetLocalTime.bat
call .\process\DVSN.bat

:Link_SF_Log_Server
set MSG=Link_SF_Log_Server
set maptimes=5

:ReLink_SF_Log_Server
if exist m:\ goto Creat_file
rem taskkill /im explorer.exe /f && start explorer && net use * /del /y && net use m: \\172.26.21.210\NB1 qmsswdl /user:nb1 >nul
net use * /del /y
net use m: \\172.26.21.210\NB1 qmsswdl /user:nb1 >nul
timeout 1
if exist m:\ goto Creat_file
timeout 2
set /a maptimes-=1
if #%maptimes%#==#0# goto fail
goto ReLink_SF_Log_Server

:Creat_file
if exist m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime% (
	cd /d m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%
	if not errorlevel 1 goto pass
)
timeout 1
md m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%
	if not errorlevel 1 goto pass
)
timeout 1
md m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%
if not errorlevel 1 (
	cd /d m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%
	if not errorlevel 1 goto pass
)

goto fail


:pass
c:
rem cd C:\TestProgram\0WM\0WM_BLT1
goto end

:fail
color 4e
c:
rem cd C:\TestProgram\0WM\0WM_BLT1
echo **** %MSG%_FAIL! ****
goto end


:end
