@echo off
set PATH=D:\xampp\jdk-21\bin;%PATH%
rmdir /s /q outcmd 2>nul
jpackage --type app-image --name FxCmd --input dist --main-jar FxCheck.jar --java-options "--module-path $APPDIR/javafx --add-modules javafx.controls" --win-console --dest outcmd
outcmd\FxCmd\FxCmd.exe
