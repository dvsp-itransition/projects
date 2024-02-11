### Задача: Работа с Docker

1. Nginx - балансировщик
2. Какой-то фронт (язык можешь выбрать сам или балванку использовать)
3. DB 

Все должно быть в . Фронт( >3 контейнеров) имеет коннект с бд и все это должно балансироваться через Nginx (на балансировщике должен быть пароль). 
Все должно разворачиваться с нуля используя Dockerfile. Задание для docker-compose

### Решение

Структура

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
Создайте install-prerequisites.sh файл для установки docker, docker-compose, apache2-utils

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

sudo systemctl enable docker
sudo usermod -aG docker ${USER}

# 3.Install docker-compose
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/bin/docker-compose
sudo chmod 777 /usr/bin/docker-compose

docker compose version
docker version

# 4. Install apache2-utils
sudo apt-get update
sudo apt-get install apache2-utils
```
и запустите с командой 

```
bash install-prerequisites.sh
```

Теперь для локального запуска приложение следуйте инструкциям ниже:

1) сделайте git clone  

```
git clone https://github.com/dvsp-itransition/docker.git
cd docker
```
2) Создайте .env файла со следующими значениями ( .env файла нужно поставить в корен папки на уровне файла docker-compose.yaml)

nano .env
```
POSTGRES_USER=postgres
POSTGRES_DB=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
```

3) Создаем .htpasswd файл для nginx внутри папки proxy (например с пользователь user и пароль user). Запустите команду ниже

```
cd proxy
sudo htpasswd -c .htpasswd user
cd ..
```

должен создасться файл .htpasswd внутри папки proxy

![img_3.png](img%2Fimg_3.png)


4) Потом запускаем докер-компос с командой ниже

```
docker-compose up -d --build
```
![img_4.png](img%2Fimg_4.png)

5) Проверяем в браузере с помощью localhost

![img_5.png](img%2Fimg_5.png)




