### Everything we have done for the cube, now convert into Helm charts

Structure
```
tree 

├── manifests
│   ├── app-deployment.yaml
│   ├── postgres-deployment.yaml
│   └── proxy-deployment.yaml
└── products
    ├── charts
    ├── Chart.yaml
    ├── templates
    │   ├── app-deployment.yaml
    │   ├── postgres-deployment.yaml
    │   └── proxy-deployment.yaml
    └── values.yaml

4 directories, 9 files
```

To install helm
```
curl https://get.helm.sh/helm-v3.12.0-linux-amd64.tar.gz > helm.tar.gz
tar xzvf helm.tar.gz
mv linux-amd64/helm /usr/local/bin
```

Now, create helm charts
```
helm create products
```
we can verify or check if the helm files are created correctly with below commands
```
helm lint products
helm template products products
helm install --dry-run --debug products products
```

To run the project locally, make git clone the project

```
git clone https://github.com/dvsp-itransition/projects.git
```

Create secrets for project DB
```
kubectl create namespace products
kubectl create secret generic db --from-literal=POSTGRES_USER=postgres --from-literal=POSTGRES_PASSWORD=postgres -n products
```

Now, run the project with helm charts 
```
helm install prodocts producs
```
![img.png](img%2Fimg.png)

![img_1.png](img%2Fimg_1.png)

![img_2.png](img%2Fimg_2.png)










