set KEYSTORE_FILE=%~dp0android123.keystore
set KEYSTORE_PASS=android123
set KEYSTORE_ALIAS=android123.keystore
set JDK_PATH=C:\"Program Files"\Java\jdk1.6.0_41
set JAVAC_PATH=%JDK_PATH%\bin\
set PATH=%PATH%;%JAVAC_PATH%;
call jarsigner -keystore %KEYSTORE_FILE% -storepass %KEYSTORE_PASS% -keypass %KEYSTORE_PASS% -signedjar %~dp0updatesigned.zip %~dp0update.zip  %KEYSTORE_ALIAS% %1
PAUSE