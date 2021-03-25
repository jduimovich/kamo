@echo off
set WAITING=%1
echo Waiting for %WAITING% to Succeeded State
set FILE=query.success 

set /a "wait_loop=20"
:wait_loop
oc get csv -n cicd | grep %WAITING% | grep Succeeded >%FILE% 
call :CheckEmpty "%FILE%"  
type %FILE%
del %FILE% 
if "%SUCCESS%"=="OK" goto :done
echo Waiting for Succeeded
timeout /t 7 /nobreak > NUL
set /a wait_loop-=1
if %wait_loop% gtr 0 goto wait_loop 
echo Timeout
goto :done 

:CheckEmpty
if %~z1 == 0 (
  set SUCCESS=NO
) else (
  set SUCCESS=OK
)
:done 

