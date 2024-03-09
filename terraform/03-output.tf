# output "vpc_id" {
#   value = module.network.vpc_id
# }

# output "vm-public-ips" {
#   value = {
#     for key, vm in aws_instance.this : key => vm.public_ip
#   }
# }

# output "vm-private_ips" {
#   value = {
#     for key, vm in aws_instance.this : key => vm.private_ip
#   }
# }