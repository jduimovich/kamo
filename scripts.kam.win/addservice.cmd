  
@echo off

call verify_env.cmd  
if %ERRORLEVEL% NEQ 0   (
     echo Some vars missing
     exit /b 1
) ELSE (
     echo All Environment Vars OK 
)

set SVC=%1
set GITOPS_REPO=%2

set RUN_THIS=kam service add ^
  --service-name %SVC%-service ^
  --app-name %SVC% ^
  --env-name dev ^
  --git-repo-url https://github.com/%MY_GITHUB_USER%/%SVC%.git ^
  --image-repo docker.io/%MY_DOCKER_USER%/%SVC%
 
echo %RUN_THIS%
%RUN_THIS%
goto :end

:error_exit
EXIT /b 1 
:end
EXIT /b 0 