@ECHO ON

CALL .\DVSN.BAT

cd ..
CALL .\LinkServer.bat
rem find /i "FAIL" .\log\%tmSN%\result\result.csv && GOTO FAILLOG
GOTO PASSLOG

:PASSLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_PASS_SLT1.csv /y
COPY .\log\%tmSN%\result\*.yml m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\ /y

GOTO END

:FAILLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_FAIL_SLT1.csv /y
COPY .\log\%tmSN%\result\*.yml m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\ /y
GOTO END


:END

