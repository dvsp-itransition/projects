### Task

To replicate everything done in Compose using minikube

### Solution

The project utilized the following Kubernetes tools and resources:

- Ingress, Ingress Nginx Controller, Deployment, Pods, Services, Replicas, PV/PVC, Resource Requests/Limits, Secrets/Config Maps, AWS ECR for storing Docker images.
- The project can be run locally at localhost.
- 3 services were used: python app, postgres db, nginx proxy/load balancer.
- Minikube was used for the Kubernetes cluster implementation.

Structure

```
root@ubuntu:~/minikube# tree
.
├── app
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── templates
│       └── index.html
├── db
│   ├── Dockerfile
│   └── init_db.sql
├── install-prerequisites.sh
├── manifestFiles
│   ├── app-deployment.yaml
│   ├── postgres-deployment.yaml
│   └── proxy-deployment.yaml
├── proxy
│   ├── Dockerfile
│   └── nginx.conf
└── README.md

5 directories, 13 files
```

Here are the commands to install Minikube, Docker, kubectl, and to start Minikube:

```
#!/bin/bash
set -euo pipefail

# 1.Set up Docker's Apt repository.
sudo apt update && sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -m 0755 -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o docker.gpg
sudo mv docker.gpg /etc/apt/keyrings/docker.gpg
sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee docker.list
sudo mv docker.list /etc/apt/sources.list.d/docker.list
sudo apt-get update

# 2.Install the Docker packages.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

# install minikube 
sudo apt update 
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.23.2/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
sudo apt install conntrack -y

# installs kubectl
curl -LO https://dl.k8s.io/release/`curl -LS https://dl.k8s.io/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl
alias k=kubectl

# install aliases
alias c=clear
alias kg="kubectl get"
alias kga="kubectl get all"
alias kgn="kubectl get namespace"
alias kgp="kubectl get pods"
alias kgd="kubectl get deploy"
alias k=kubectl
alias h=helm

# start minikube
minikube start --vm-driver=none
kubectl cluster-info
minikube status

minikube addons enable metrics-server
minikube addons enable dashboard 
# minikube dashboard
```

Make sure to execute these commands in your terminal. They will install Docker, kubectl, and Minikube, and starts Minikube for you.

Here, Pre-created repositories for db, app, proxy to store images in AWS ECR.

![img.png](img%2Fimg.png)

We have also created Docker images for DB, App, Proxy, and push them to the ECR Registry.

```
cd db
docker build -t db .
docker tag db:latest public.ecr.aws/o5j9v9p7/db:latest
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o5j9v9p7
docker push public.ecr.aws/o5j9v9p7/db:latest

cd app
docker build -t app .
docker tag app:latest public.ecr.aws/o5j9v9p7/app:latest
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o5j9v9p7
docker push public.ecr.aws/o5j9v9p7/app:latest

cd proxy
docker build -t proxy .
docker tag proxy:latest public.ecr.aws/o5j9v9p7/proxy:latest
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o5j9v9p7
docker push public.ecr.aws/o5j9v9p7/proxy:latest
```
For local deployment:

Clone the project repository https://github.com/dvsp-itransition/projects.git

```
git clone https://github.com/dvsp-itransition/projects.git
```
Create secrets for database
```
kubectl create secret generic db --from-literal=POSTGRES_USER=postgres --from-literal=POSTGRES_PASSWORD=postgres -n products
```

Run the manifest files

```
cd minikube/manifestFiles
kubectl apply -f postgres-deployment.yaml
kubectl apply -f app-deployment.yaml
kubectl apply -f proxy-deployment.yaml
```

![kga.png](img%2Fkga.png)

Activate Ingress
```
minikube addons enable ingress
```
Check in the browser using localhost

![app.png](img%2Fapp.png)

### Now, we have also implemented the application in Minikube Kubernetes cluster.

Additionally, we can also view it through the Minikube dashboard
```
minikube dashboard
```
![dash1.png](img%2Fdash1.png)

![dash2.png](img%2Fdash2.png)

