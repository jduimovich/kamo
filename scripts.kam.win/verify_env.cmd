  
@echo off 
goto :entry 

:check_env 
IF DEFINED %1 (
     echo %1 is defined  
) ELSE (
     echo %1 is missing
     goto :error_exit
)
goto :end 

:entry  

call :check_env MY_GITHUB_USER
call :check_env MY_GITHUB_TOKEN
call :check_env MY_DOCKER_USER
call :check_env GITOPS_AUTH_FILE
 
goto :end

:error_exit  
EXIT /b 1 
:end
EXIT /b 0 