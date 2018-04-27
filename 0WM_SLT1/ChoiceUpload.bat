@echo off
color 4e
cls
title #Please Choice UP SF Fail#
echo.
echo    ***************************************************
echo    **    Item Test Fail   本次项目测试Fail是否上传！**
echo    **   1.    NO Upload SF Fail  不上传Fail到SF     **
echo    **   2.    Upload SF Fail     上传Fail到SF!!     **
echo    ***************************************************
echo    ********（请选择输入 1 或 2 然后回车或Enter）******
echo    ***************************************************
echo.
set ChoiceNum=
set /p ChoiceNum="Your Choice: "
if not defined ChoiceNum goto NO_Upload
if %ChoiceNum%==1 goto NO_Upload
if %ChoiceNum%==2 goto YES_Upload

:NO_Upload
set Upload=NO
echo Upload=NO
goto end

:YES_Upload
set Upload=YES
echo Upload=YES
goto end

:end