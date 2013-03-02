set KEYSTORE_FILE=%~dp0apksigner.keystore
set KEYSTORE_PASS=apksigner
set KEYSTORE_ALIAS=apksigner.keystore
set JDK_PATH=C:\"Program Files"\Java\jdk1.7.0_15
set JAVAC_PATH=%JDK_PATH%\bin\
set PATH=%PATH%;%JAVAC_PATH%;
call jarsigner -keystore %KEYSTORE_FILE% -storepass %KEYSTORE_PASS% -keypass %KEYSTORE_PASS% -signedjar %~dp0updatesigned.zip %~dp0update.zip  %KEYSTORE_ALIAS% %1
PAUSE