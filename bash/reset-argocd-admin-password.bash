#!/bin/bash

argocdAdminPassword=$0
argocdInternalIP=$(kubectl -n argocd get svc argocd-server --output=jsonpath='{.spec.clusterIP}')

passwordsalt=$(python3 -c "import bcrypt; print(bcrypt.hashpw(b'${argocdAdminPassword}', bcrypt.gensalt()).decode())")

echo ${passwordsalt}

## reset password
kubectl -n argocd patch secret argocd-secret -p '{"stringData": {
    "admin.password": "${passwordsalt}",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"}}'
