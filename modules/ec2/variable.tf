# EC2 Configurations

variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "key_name" {
    type = string
    default = "song1-key.pem"

}
variable "ami"{
    type = string 
    default = "ami-091a822378848a5bf"
}

variable "sg_id"{
    type=string
}

variable "public_subnet_id"{
    type = string
}
variable "private_subnet_id"{
    type = list(string)
}