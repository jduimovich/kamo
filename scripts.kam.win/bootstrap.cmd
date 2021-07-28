  
@echo off

call  %~dp0verify_env.cmd  
if %ERRORLEVEL% NEQ 0   (
     echo Some vars missing
     exit /b 1
) ELSE (
     echo All Environment Vars OK 
)

set SVC=%1
set GITOPS_REPO=%2
set PUSH=%3
IF "%SVC%"=="" (GOTO :missing) 
IF "%GITOPS_REPO%"=="" (GOTO :missing) 
if "%PUSH%"==""   (
     set PUSH=false 
) 

echo Bootstrap %SVC% in repo %GITOPS_REPO%, push-to-git  %PUSH%

set RUN_THIS=kam bootstrap ^
  --service-repo-url https://github.com/%MY_GITHUB_USER%/%SVC%.git ^
  --gitops-repo-url https://github.com/%MY_GITHUB_USER%/%GITOPS_REPO%.git ^
  --image-repo docker.io/%MY_DOCKER_USER%/%GITOPS_REPO% ^
  --dockercfgjson  %GITOPS_AUTH_FILE% ^
  --git-host-access-token %MY_GITHUB_TOKEN% ^
  --output %GITOPS_REPO% ^
  --push-to-git=%PUSH%

echo %RUN_THIS%
%RUN_THIS%
goto :end

:missing
echo missing params  bootstrap service gitops-repo 

:error_exit
EXIT /b 1 
:end
EXIT /b 0 