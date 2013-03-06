@ECHO off
setlocal enabledelayedexpansion
COLOR 0A
if (%1)==(0) goto skipme
if (%1) neq () goto skipme
ECHO *********************************************************************************** >> signer.log
ECHO ^*                          %date% -- %time%^ >> signer.log                         * >> signer.log
ECHO *********************************************************************************** >> signer.log
Setup 0 2>> signer.log


:error

:skipme
cd "%~dp0"
mode con:cols=85 lines=50

set capp=None
set KEYSTORE_FILE=apksigner.keystore
set KEYSTORE_PASS=apksigner
set KEYSTORE_ALIAS=apksigner.keystore
set JAVAC_PATH=%JAVA_HOME%\bin\
set PATH=%PATH%;%JAVAC_PATH%;

if errorlevel 1 goto erradb

cls

:RESTART
cd "%~dp0"
set menunr=GARBAGE
cls

ECHO ***********************************************************************************
ECHO *                                                                                 *
ECHO *                         APK MULTI-TOOL SIGNER APP                               *
ECHO *                                                                                 *
ECHO ***********************************************************************************
ECHO *                                                                                 *
ECHO *  1 Sign UPDATE.zip                                                              *
ECHO *    This simply signs any ROM that you want to sign simple rename the ROMS       *
ECHO *    flashable zip file to update.zip and run this option                         *
ECHO *                                                                                 *
ECHO ***********************************************************************************
ECHO *                                                                                 *
ECHO *  2 Sign unsigned APK FILE                                                       *
ECHO *                                                                                 *
ECHO ***********************************************************************************
ECHO *                                                                                 *
ECHO *  3 Please select a apk file to sign                                             *
ECHO *                                                                                 *
ECHO ***********************************************************************************
SET /P menunr=Please make your decision:
IF %menunr%==1 (goto APKSIGNERZIP)
IF %menunr%==2 (goto APKSIGNERAPK )
IF %menunr%==3 (goto filesel)
IF %capp%==None goto noproj



:APKSIGNERZIP
ECHO Signing UPDATE.ZIP Please Stand by.
call jarsigner -keystore tools/%KEYSTORE_FILE% -storepass %KEYSTORE_PASS% -keypass %KEYSTORE_PASS% -signedjar %~dp0updatesigned.zip %~dp0update.zip  %KEYSTORE_ALIAS% %1
IF errorlevel 1 (
ECHO "An Error Occured, Please Check The Log file for more information"
PAUSE
)
PAUSE
GOTO RESTART

:APKSIGNERAPK
call jarsigner -keystore tools/%KEYSTORE_FILE% -storepass %KEYSTORE_PASS% -keypass %KEYSTORE_PASS% -signedjar place-apk-here-for-signing/signed%capp% place-apk-here-for-signing/%capp%  %KEYSTORE_ALIAS% %1
IF errorlevel 1 (
ECHO "An Error Occured, Please Check The Log file for more information"
PAUSE
)
PAUSE
GOTO RESTART

:noproj
ECHO Please Select A Project To Work On (Option #3)
PAUSE
goto restart

:filesel
CLS
set /A count=0
FOR %%F IN (place-apk-here-for-signing/*.apk) DO (
set /A count+=1
set a!count!=%%F
IF /I !count! LEQ 9 (ECHO ^- !count!  - %%F )
IF /I !count! GTR 10 (ECHO ^- !count! - %%F )
)
ECHO.
ECHO Choose the app to be set as current project?
set /P INPUT=Enter It's Number: %=%
IF /I %INPUT% GTR !count! (goto chc)
IF /I %INPUT% LSS 1 (goto chc)
set capp=!a%INPUT%!
set jar=0
set ext=jar
IF "!capp:%ext%=!" NEQ "%capp%" set jar=1
goto restart
:chc
set capp=None
goto restart