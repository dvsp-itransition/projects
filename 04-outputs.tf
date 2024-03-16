#--------------
# RDS Outputs
#--------------
output "RDS-Master" {
  value = module.rds-master.rds_instance_endpoint
}

output "RDS-Replica" {
  value = module.rds-replica.rds_instance_endpoint
}