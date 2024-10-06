# Self Managed Argo CD - App of Everything

[![CodeFactor](https://www.codefactor.io/repository/github/nathmahale/argocd/badge)](https://www.codefactor.io/repository/github/nathmahale/argocd)

## Table of Contents

- [Self Managed Argo CD - App of Everything](#self-managed-argo-cd---app-of-everything)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Clone Repository](#clone-repository)
  - [Create Local Kubernetes Cluster](#create-local-kubernetes-cluster)
  - [Git Repository Hierarchy](#git-repository-hierarchy)
- [Create App Of Everything Pattern](#create-app-of-everything-pattern)
- [Install Argo CD Using Helm](#install-argo-cd-using-helm)
- [Demo With Sample Application](#demo-with-sample-application)
- [Cleanup](#cleanup)

## Introduction

This project aims to install a self-managed Argo CD using the App of App pattern. Full instructions and explanation can be found in the Medium article [Self Managed Argo CD — App Of Everything](https://medium.com/devopsturkiye/self-managed-argo-cd-app-of-everything-a226eb100cf0).

## Clone Repository

Clone kurtburak/argocd repository to your local device.

```bash
git clone https://github.com/nathmahale/argocd.git
```

## Create Local Kubernetes Cluster

> Create Local Kubernetes Cluster with the tool of your choice

Check cluster is running and healthy

```bash
kubectl cluster-info — context kind-my-cluster

Kubernetes control plane is running at https://127.0.0.1:50589
KubeDNS is running at https://127.0.0.1:50589/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
To further debug and diagnose cluster problems, use ‘kubectl cluster-info dump’.
```

## Git Repository Hierarchy

Folder structure below is used in this project. You are free to change it.

```bash
argocd/
├── argocd-appprojects      # stores ArgoCD App Project's yaml files
├── argocd-apps             # stores ArgoCD Application's yaml files
├── argocd-install          # stores Argo CD installation files
│ ├── argo-cd               # argo/argo-cd helm chart
│ └── values-override.yaml  # custom values.yaml for argo-cd chart
```

## Create App Of Everything Pattern

Open `argocd-install/values-override.yaml` with your favorite editor and modify related values.

```bash
vi argocd-install/values-override.yaml
```

Or update it with your values.
Example --

```bash
cat << EOF > argocd-install/values-override.yaml
server:
  configEnabled: true
  config:
    repositories: |
      - type: git
        url: https://github.com/nathmahale/argocd.git
      - name: argo-helm
        type: helm
        url: https://argoproj.github.io/argo-helm
  additionalApplications: 
    - name: argocd
      namespace: argocd
      destination:
        namespace: argocd
        server: https://kubernetes.default.svc
      project: argocd
      source:
        helm:
          version: v3
          valueFiles:
          - values.yaml
          - ../values-override.yaml
        path: argocd-install/argo-cd
        repoURL: https://github.com/nathmahale/argocd.git
        targetRevision: HEAD
      syncPolicy:
        syncOptions:
        - CreateNamespace=true
    - name: argocd-apps
      namespace: argocd
      destination:
        namespace: argocd
        server: https://kubernetes.default.svc
      project: argocd
      source:
        path: argocd-apps
        repoURL: https://github.com/nathmahale/argocd.git
        targetRevision: HEAD
        directory:
          recurse: true
          jsonnet: {}
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
    - name: argocd-appprojects
      namespace: argocd
      destination:
        namespace: argocd
        server: https://kubernetes.default.svc
      project: argocd
      source:
        path: argocd-appprojects
        repoURL: https://github.com/nathmahale/argocd.git
        targetRevision: HEAD
        directory:
          recurse: true
          jsonnet: {}
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
  additionalProjects: 
  - name: argocd
    namespace: argocd
    additionalLabels: {}
    additionalAnnotations: {}
    description: Argocd Project
    sourceRepos:
    - '*'
    destinations:
    - namespace: argocd
      server: https://kubernetes.default.svc
    clusterResourceWhitelist:
    - group: '*'
      kind: '*'
    orphanedResources:
      warn: false
EOF
```

## Install Argo CD Using Helm

Go to argocd directory.

```bash
cd argocd/argocd-install/
helm install argocd ./argo-cd \
    --namespace=argocd \
    --create-namespace \
    -f values-override.yaml
```

Wait until all pods are running.

```bash
kubectl -n argocd get pods -o wide

NAME                                            READY   STATUS    RESTARTS
argocd-application-controller-bcc4f7584-vsbc7   1/1     Running   0       
argocd-dex-server-77f6fc6cfb-v844k              1/1     Running   0       
argocd-redis-7966999975-68hm7                   1/1     Running   0       
argocd-repo-server-6b76b7ff6b-2fgqr             1/1     Running   0       
argocd-server-848dbc6cb4-r48qp                  1/1     Running   0
```

Get initial admin password.

```bash
kubectl -n argocd get secrets argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
```

Forward argocd-server service port 80 to localhost:8080 using kubectl.

```bash
kubectl -n argocd port-forward service/argocd-server 8080:80
```

Browse `http://localhost:8080` and login with initial admin password.

## Demo With Sample Application

Create an application project definition file called *sample-project*.

```bash
cat << EOF > argocd-appprojects/sample-project.yaml
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: sample-project
  namespace: argocd
spec:
  clusterResourceWhitelist:
  - group: '*'
    kind: '*'
  destinations:
  - namespace: sample-app
    server: https://kubernetes.default.svc
  orphanedResources:
    warn: false
  sourceRepos:
  - '*'
EOF
```

Push changes to your repository.

```bash
git add argocd-appprojects/sample-project.yaml
git commit -m "Create sample-project"
git push
```

Create a saple applicaiton definition yaml file called *sample-app* under argocd-apps.

```bash
cat << EOF >> argocd-apps/sample-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sample-app
  namespace: argocd
spec:
  destination:
    namespace: sample-app
    server: https://kubernetes.default.svc
  project: sample-project
  source:
    path: sample-app/
    repoURL: https://github.com/nathmahale/argocd.git
    targetRevision: HEAD
  syncPolicy:
    syncOptions:
    - CreateNamespace=true
    automated:
      selfHeal: true
      prune: true
EOF
```

Push changes to your repository.

```bash
git add argocd-apps/sample-app.yaml
git commit -m "Create application"
git push
```

## Cleanup

Remove application and applicaiton project.

```bash
rm -f argocd-apps/sample-app.yaml
rm -f argocd-appprojects/sample-project.yaml
git rm argocd-apps/sample-app.yaml
git rm argocd-appprojects/sample-project.yaml
git commit -m "Remove app and project."
git push
```