@echo off 
curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | jq .tag_name > tag_name

set /P V_QUOTES=< tag_name
del tag_name
SET VERSION=%V_QUOTES:"=%

SET DOWNLOAD="https://github.com/argoproj/argo-cd/releases/download/%VERSION%/argocd-windows-amd64.exe"
echo Fetching binary from %DOWNLOAD% into argocd.exe 
curl -sL --output argocd.exe %DOWNLOAD%
