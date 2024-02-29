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
.
├── 01-main.tf
├── 02-variables.tf
├── 03-output.tf
├── modules
│   └── simple_network
│       ├── 1-vpc.tf
│       ├── 2-subnets.tf
│       ├── 3-ngw.tf
│       ├── 4-routes.tf
│       ├── 5-variables.tf
│       ├── 6-locals.tf
│       └── 7-output.tf
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
main.tf file
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0" # min provider version    
    }
  }

  required_version = ">= 0.13" # min Terraform version
}

provider "aws" {
  region = var.region
}

module "network" {  
  source = "git@github.com:dvsp-itransition/terraform-modules.git//simple_network"
  vpc_cidr    = var.vpc_cidr
  region      = var.region
  environment = var.environment
}
```

The network module is available in a separate repository at the following address:
```
https://github.com/dvsp-itransition/terraform-modules/tree/main/simple_network
```

As well, the local copy is here: modules/simple_network

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

![img-3.png](img%2Fimg-3.png)