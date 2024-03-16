# -------------------
# General variables
# -------------------
region      = "us-east-2"
environment = "dev"

# --------------------------
# RDS variables
# --------------------------
identifier = "Postgres"
engine = "postgres"
engine_version = "14" 
instance_class = "db.t3.micro"

allocated_storage = 20
max_allocated_storage = 100

db_name = "demo-DB"
username = "postgres"
password = "postgres"
port = 5432






