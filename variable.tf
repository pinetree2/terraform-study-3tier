variable "tag"{
    type = string
    default = "song"
} 

variable "region" {
    type = string
    default = "ap-northeast-2"
}



# EC2 Configurations
default_instance_type = "t2.micro"
key_pair      = "song-key.pem"

# Security Groups
# tuple : list of {description, source_cidr, from, to, protocol}
source_bastion_cidrs = [
  {
    desc     = "Bastion SSH Inbound",
    cidrs    = ["0.0.0.0/0"],
    from     = 22,
    to       = 22,
    protocol = "tcp",
  },
]
source_web_cidrs = [
  {
    desc     = "WEB HTTP Inbound",
    cidrs    = ["0.0.0.0/0"],
    from     = 80,
    to       = 80,
    protocol = "tcp",
  },
]

source_was_cidrs = [
  {
    desc     = "WAS HTTP Inbound",
    cidrs    = ["0.0.0.0/0"],
    from     = 8080,
    to       = 8080,
    protocol = "tcp",
  },
]

// DB Instance
db_identifier = "test-mysql-57"
db_engine = "mysql"
db_engine_version = "5.7"
db_allocated_storage = "30"
db_instance_class = "db.t3.micro"
db_multi_az = false

db_username = "admin"
db_password = "passw0rd1!"

// Option Group
db_engine_name = "mysql"
db_major_engine_version = "5.7"

