@echo off
color 4e
cls
title #Please Choice UP SF Fail#
echo.
echo    ***************************************************
echo    **    Item Test Fail   ������Ŀ����Fail�Ƿ��ϴ���**
echo    **   1.    NO Upload SF Fail  ���ϴ�Fail��SF     **
echo    **   2.    Upload SF Fail     �ϴ�Fail��SF!!     **
echo    ***************************************************
echo    ********����ѡ������ 1 �� 2 Ȼ��س���Enter��******
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