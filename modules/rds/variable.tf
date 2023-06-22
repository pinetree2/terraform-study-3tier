variable "db_subnet_cidr"{
    type = list(string)
    default = ["10.0.14.0/24", "10.0.15.0/24"]
}

variable "available_azs" {
    type = list(string)
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "sg_id"{
    type = string
}

variable "vpc_id"{
    type = string
}

variable "tag"{
    type = string
}