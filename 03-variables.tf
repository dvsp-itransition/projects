# -------------------
# General variables
# -------------------
variable "region" {
  default     = "us-east-2"
  type        = string
  description = "The region where the infrastructure will be deployed"
}

variable "environment" {
  default     = "dev"
  type        = string
  description = "The environment for which the infrastructure is intended (e.g., dev, test, prod)"
}

# -------------------
# RDS Variables
# -------------------

variable "identifier" {
  description = "The identifier for the database."
  default     = null
  type        = string
}

variable "engine" {
  description = "The type of database engine to be used."
  default     = null
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine."
  default     = null
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage to be allocated for the database, in gigabytes."
  default     = null
  type        = number
}

variable "max_allocated_storage" {
  description = "The maximum storage auto-scaling limit for the database, up to 100GB."
  default     = null
  type        = number
}

variable "instance_class" {
  description = "The instance type to be used for the database."
  default     = null
  type        = string
}

variable "db_name" {
  description = "The name of the database."
  default     = null
  type        = string
}

variable "username" {
  description = "The username for accessing the database."
  default     = null
  type        = string
  sensitive   = true
}

variable "password" {
  description = "The password for accessing the database."
  default     = null
  type        = string
  sensitive   = true
}

variable "port" {
  description = "The port on which the database listens for connections."
  default     = null
  type        = number
}

variable "multi_az" {  
  description = "Enable Multi-AZ deployment for high availability."
  type        = bool
  default     = false
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group."
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {  
  description = "The IDs of the VPC security groups associated with the database."
  type        = list(string)
  default     = null
}

variable "backup_window" {  
  description = "The daily time range (in UTC) during which automated backups are created" 
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true, no DBSnapshot is created; if false, a DB snapshot is created before the DB instance is deleted."
  type        = bool
  default     = null
}

variable "deletion_protection" {
  description = "Indicates whether deletion protection is enabled for the database. When set to true, the database cannot be deleted."
  type        = bool
  default     = null
}

variable "backup_retention_period" {
  description = "The number of days to keep automated backups."
  type        = number
  default     = null
}

variable "replica_mode" {
  description = "Specifies the mode of the replica. For Oracle instances, this can be 'mounted' or 'open-read-only'. The default mode is 'open-read'."
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "The identifier of the source database to be replicated."
  type        = string  
  default     = null
}
