
@echo off

crc console --credentials  -o json  | jq .clusterConfig.adminCredentials.password >openshift.login.token
set /P LOGINQ=< openshift.login.token
del openshift.login.token
Set LOGIN=%LOGINQ:"=%

echo Logging into local CRC cluster 
oc login -u kubeadmin -p %LOGIN% https://api.crc.testing:6443

echo Create cicd namespace
oc new-project cicd

echo Setup the cluster for sealed secrets and OpenShift GitOps operator
call setup-operators.cmd 
 