### Simple network with Terraform

Create a Terraform module that will create the following resources:
- VPC
- Public subnet x2
- Private subnet x2
- Private route table x2
- Public route table
- NAT Gateway x2
- Internet gateway

Module Input Parameters:
- vpc_cidr (for example: "10.0.0.0/16")
- region (the region where the VPC will be created, for example: "eu-west-2")
- environment (all created resources should be tagged with a key "environment" and the accepted value, for example: "dev")

Output Values: 
- vpc_id

Example of module usage:

```
module "network" {
    source      = "terraform/modules/simple_network"
    vpc_cidr    = var.vpc_cidr
    region      = var.region
    environment = var.environment
}
```

Diagram:

![diagram.png](img%2Fdiagram.png)

### Solution:

Structure:

```
├── main.tf
├── modules
│   └── simple_network
│       ├── main.tf
│       ├── output.tf
│       └── vars.tf
```
Installing Terraform

```
# Installs terraform
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt-get install terraform -y

# installs AWS Cli:
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt install unzip -y && unzip awscliv2.zip
sudo ./aws/install --bin-dir /usr/bin --install-dir /usr/bin/aws-cli --update 
```

Configuring AWS Access/Secret Keys

```
aws configure # creates ~/.aws/credentials file
```
main.tf файл
```
provider "aws" {
  region = var.region
}

module "network" {  
  source      = "git::https://github.com/dvsp-itransition/terraform-module-network.git"
  vpc_cidr    = var.vpc_cidr
  region      = var.region
  environment = var.environment
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region" {
  default = "eu-west-2"
}

variable "environment" {
  default = "dev"
}

output "vpc_id" {
  value = module.network.vpc_id
}
```

Initializing the project, validating the configuration, and run deployment:

```
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply --auto-approve
```

### Results:

![img.png](img%2Fimg.png)

![img_1.png](img%2Fimg_1.png)

![img_2.png](img%2Fimg_2.png)