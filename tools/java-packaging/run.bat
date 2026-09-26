@echo off
set PATH=D:\xampp\jdk-21\bin;%PATH%
javac *.java
jar --create --file Specials.jar --main-class Specials *.class
jar --list --file Specials.jar
java -jar Specials.jar
