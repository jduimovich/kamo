  
@echo off 
goto :entry 

:check_env 
IF DEFINED %1 (
     echo %1 is defined %%1%
) ELSE (
     echo %1 is missing
     goto :error_exit
)
goto :end 

:entry  

call :check_env MY_GIT_USER
call :check_env MY_GITHUB_TOKEN
call :check_env MY_REPO_USER
call :check_env GITOPS_AUTH_FILE
 
goto :end

:error_exit 
echo Error Exit
EXIT /b 1 
:end
EXIT /b 0 