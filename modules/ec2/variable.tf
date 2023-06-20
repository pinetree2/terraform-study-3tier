# EC2 Configurations

variable "default_instance_type" {
    type = string
    default = "t2.micro"
}
variable "key_pair" {
    type = string
    default = "song-key.pem"

}