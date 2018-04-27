@ECHO ON
goto end

CALL .\DVSN.BAT

cd ..
CALL .\LinkServer.bat
find /i "FAIL" .\log\%tmSN%\result\result.csv && GOTO FAILLOG
GOTO PASSLOG

:PASSLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_PASS_SLT1.csv /y
GOTO END

:FAILLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_FAIL_SLT1.csv /y
GOTO END


:END

