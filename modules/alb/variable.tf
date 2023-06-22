variable "security_group_id"{
    type= string
}

variable "private_subnet_id"{
    type = list(string)
}

variable "vpc_id"{
    type = string
}

variable "private_instance_id"{
    type = list(string)
}