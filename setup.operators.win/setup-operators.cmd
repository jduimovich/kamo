@echo off
echo "Starting sealed-secrets operator installation"
oc create -f deploy\operator-group.yaml
oc create -f deploy\seal-secrets-operator-subscription.yaml
call wait-for-csv sealed-secrets-operator  
echo "Completed sealed-secrets operator installation"

echo "Starting sealed-secrets operator instance creation"
oc create -f deploy\sealedsecretscontroler.yaml 
echo "Completed sealed-secrets operator instance creation"

echo "Starting OpenShift GitOps operator installation" 
oc create -f   deploy\gitops-operator-subscription.yaml  
call wait-for-csv openshift-gitops-operator

echo "Wait  before adding admin access to argocd" 
timeout /t 10 /nobreak > NUL
echo "Provide cluster-admin access to argocd-application-controller service account"
oc adm policy add-cluster-role-to-user cluster-admin system:serviceaccount:openshift-gitops:argocd-cluster-argocd-application-controller
