### Task: Working with Docker

1. Nginx - Load Balancer
2. Some Frontend (You can choose the language yourself)
3. Database (DB)

Everything should be in `. Frontend (>3 containers) should have a connection to the database, and all of this should be balanced through Nginx (there should be a password on the load balancer). 
Everything should be deployed from scratch using Dockerfile. The task is for docker-compose.

### Solution

Structure

```
tree
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
├── docker-compose.yaml
├── img
│   ├── img_1.png
│   ├── img_2.png
│   └── img.png
├── install-prerequisites.sh
├── proxy
│   ├── Dockerfile
│   └── nginx.conf
└── README.md

5 directories, 14 files

```
Create an install-prerequisites.sh file to install docker, docker-compose, apache2-utils.

nano install-prerequisites.sh
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

sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

# 3.Install docker-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/bin/docker-compose
sudo chmod 777 /usr/bin/docker-compose

docker compose version
docker version

# 4. Install apache2-utils
sudo apt-get update
sudo apt-get install apache2-utils
```
and run with the command:

```
bash install-prerequisites.sh
```

Now, to run the application locally, follow the instructions below:

1) Clone the git repository. 

```
git clone https://github.com/dvsp-itransition/docker.git
cd docker
```
2) Create a .env file and fill the empty values.(the .env file should be placed in the root folder at the same level as the docker-compose.yaml file).

nano .env
```
POSTGRES_USER=""
POSTGRES_DB=""
POSTGRES_PASSWORD=""
POSTGRES_HOST=""
POSTGRES_PORT=""
```

3) Create a .htpasswd file for nginx inside the proxy folder (for example, with the user "user" and the password "user"). Run the command below.

```
cd proxy
sudo htpasswd -c .htpasswd user
cd ..
```

The file .htpasswd should be created inside the proxy folder.

![img_3.png](img%2Fimg_3.png)


4) Then run Docker Compose with the command below.

```
docker-compose up -d --build
```
![img_4.png](img%2Fimg_4.png)

5) Check in the browser using localhost.

![img_5.png](img%2Fimg_5.png)




