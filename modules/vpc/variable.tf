variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    type = list(string)
    default = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "private_subnet_cidr"{
    type = list(string)
    default = ["10.0.10.0/24", "10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]
}
variable "db_subnet_cidr"{
    type = list(string)
    default = ["10.0.20.0/24", "10.0.21.0/24"]
}
variable "available_azs" {
    type = list(string)
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}
variable "tag" {
    type = string
}