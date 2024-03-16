module "rds-master" {
  source = "git@github.com:dvsp-itransition/terraform-module-RDS.git"

  identifier           = "${var.identifier}-master"
  engine               = var.engine
  engine_version       = var.engine_version    
  instance_class       = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

  multi_az               = false
  db_subnet_group_name   = try("subnet-6575768886", null) 
  vpc_security_group_ids = try("sg-6575768886", null) 
  
  # Backups also would be needed to create a replicas
  backup_retention_period = 1
  backup_window                   = "03:00-06:00"
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name        = "${var.environment}-master"
    environment = var.environment
  }

}

module "rds-replica" {
  source = "git@github.com:dvsp-itransition/terraform-module-RDS.git"

  identifier           = "${var.identifier}-replica"
  replicate_source_db  = module.rdb-master.db_instance_identifier 
  instance_class       = var.instance_class

  multi_az               = false
  db_subnet_group_name   = try("subnet-6575768886", null) 
  vpc_security_group_ids = try("sg-6575768886", null) 
  
  backup_window                   = "03:00-06:00"  
  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false  

  depends_on = [ module.rds-master ]

  tags = {
    Name        = "${var.environment}-replica"
    environment = var.environment
  }  
}

# Each Master & Replicas can be added by using separate modules 