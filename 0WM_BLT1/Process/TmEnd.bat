@ECHO ON
CALL .\DVSN.BAT
cd ..
CALL .\LinkServer.bat
find /i "FAIL" .\log\%tmSN%\result\result.csv && GOTO FAILLOG
GOTO PASSLOG

:PASSLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_PASS_BLT1.csv /y
GOTO END

:FAILLOG
COPY .\log\%tmSN%\result\result.csv m:\0WM\Testlog\%LeeDate%\%tmStationName%\%tmLineName%\%tmFixtureID%\%tmSN%_%LeeTime%\%tmSN%_FAIL_BLT1.csv /y
GOTO END


:END
REM c:
REM cd c:\TestProgram\0WM\0WM_BLT1
REM RS232.exe poweroff 1000 A3
