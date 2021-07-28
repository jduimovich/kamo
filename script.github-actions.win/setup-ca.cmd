@echo off 
rem First, name your Service Account (the Kubernetes shortname is "sa") and create it.
set SA=github-action-sa 
oc create sa %SA%

rem Now, we have to find the `name` of the secret in which the Service Account's apiserver token is stored.
rem The following command will output two secrets. 
oc get sa %SA% -o jsonpath='{.secrets[*].name}' >tmp.secret
set /P SECRETSQ=< tmp.secret
set SECRETS=%SECRETSQ:'=%  
echo NOMATCH >tmp.per_line 
for %a in (%SECRETS%) do echo %%a >>tmp.per_line  
grep  "token" tmp.per_line > tmp.secret_name 
set /P SECRET_NAMEQ=< tmp.secret_name 
set SECRET_NAME=%SECRET_NAMEQ:'=%   

oc get secret %SECRET_NAME%  -o jsonpath='{.data.token}' > tmp.token
set /P ENCODED_TOKENQ=< tmp.token
set ENCODED_TOKEN=%ENCODED_TOKENQ:'=%   
echo %ENCODED_TOKEN% > tmp.token
certutil -decode tmp.token tmp.data > nul
set /P TOKEN=< tmp.data 

del tmp.secret tmp.per_line  tmp.secret_name tmp.secret_name  tmp.token tmp.data
echo TOKEN is %TOKEN% and is in your clipboard
echo|set /p=%TOKEN%| clip