  
@echo off

call verify_env.cmd 

set MY_GIT_USER=jduimovich 
set MY_REPO_USER=jduimovich

set SVC=haproxy
set GITOPS=gt-app

set RUN_THIS=kam bootstrap ^
  --service-repo-url https://github.com/%MY_GIT_USER%/%SVC%.git ^
  --gitops-repo-url https://github.com/%MY_GIT_USER%/%GITOPS%.git ^
  --image-repo docker.io/%MY_REPO_USER%/%GITOPS% ^
  --dockercfgjson  \bin\jduimovich-gitops-auth.json ^
  --git-host-access-token %MY_GITHUB_TOKEN% ^
  --output %GITOPS% ^
  --push-to-git=true

echo %RUN_THIS%
%RUN_THIS%
goto :end

:error_exit
EXIT /b 1 
:end
EXIT /b 0 