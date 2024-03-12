#--------------
# EC2 Outputs
#--------------
output "public-ip" {
  value = module.ec2_instance.public-ip
}

output "private_ip" {
  value = module.ec2_instance.private_ip
}

