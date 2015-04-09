@echo off
REM Author Medet
REM Теперь не нужно при изменениях в директории libs версий или названий исходников прописывать classpath

set HOME=%~dp0
set LIBS=%HOME%libs/
set JAVA_START_OPTS=-Xms128m -Xmx512m
set MAIN_CLASS=kz.pchelka.server.Server
set CLASSPATH=.
set _JAVACMD=java

TITLE NB 4ms workflow

cd %HOME%

REM Собираем CLASSPATH. Инфо по работе for http://ss64.com/nt/for_r.html
FOR /R %LIBS% %%G IN (*.jar) DO (call :list_classpath %%G)
set CLASSPATH=%CLASSPATH:\=/%
goto startJava
:list_classpath
	set CLASSPATH=%CLASSPATH%;%1
	exit /b

:startJava
echo %_JAVACMD% %JAVA_START_OPTS% -classpath %CLASSPATH% %MAIN_CLASS%
%_JAVACMD% %JAVA_START_OPTS% -classpath %CLASSPATH% %MAIN_CLASS%

if errorlevel 1 pause