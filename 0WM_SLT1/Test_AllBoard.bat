@echo oN

@rem Change History:
@rem =========================================
@rem Rev.: 3A   Ryan Xue    04/27/2018
@rem 1. First release for 0WM DVT build. 
@rem =========================================
@rem Rev.: 3B   Ryan Xue    05/04/2018
@rem 1. Skip this test item for DVT build.
@rem 2. FB customer program Not ready.
@rem =========================================

@rem Testing Procedure:
@rem ==================
@rem 
@rem ==================

@rem Linux Command(tool):
@rem ===================
@rem ?
@rem ===================


:START
CALL .\Process\DVSN.BAT
CALL .\log\%tmSN%\result\ChkBoardPresent.cmd
CALL .\log\%tmSN%\result\ChkAudioBoard.cmd
CALL .\log\%tmSN%\result\ChkMainBoard.cmd
CALL .\log\%tmSN%\result\ChkVideoBoard.cmd
IF /I not #%ChkBoardPresent%#==#PASS# goto fail
IF /I not #%ChkAudioBoard%#==#PASS# goto fail
IF /I not #%ChkMainBoard%#==#PASS# goto fail
IF /I not #%ChkVideoBoard%#==#PASS# goto fail
goto pass

:PASS
color 2f
>.\log\Test_AllBoard_CheckLog.bat echo set AllBoard=PASS
>>.\log\Test_AllBoard_CheckLog.bat echo set TestResult=PASS
cd .\Process
call sdtCheckLog.exe Model_MLBTEST.cfg AllBoard
cd..
GOTO END

:FAIL
color 4f
ECHO ************************************************************
ECHO *..........................................................*
ECHO *................. Check AllBoard FAIL! ...................*
ECHO *..........................................................*
ECHO ************************************************************
MSG "Check AllBoard FAIL!" 6 650 200 15
pause
color 07
goto end


:END