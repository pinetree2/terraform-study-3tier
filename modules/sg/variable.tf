# Security Groups
# tuple : list of {description, source_cidr, from, to, protocol}

variable "source_bastion_cidrs" {
  type = list(object({
    desc     = string
    cidrs    = list(string)
    from     = number
    to       = number
    protocol = string
  }))
  default = [
    {
      desc     = "Bastion SSH Inbound"
      cidrs    = ["0.0.0.0/0"]
      from     = 22
      to       = 22
      protocol = "tcp"
    }
  ]
}

variable "source_web_cidrs" {
  type = list(object({
    desc     = string
    cidrs    = list(string)
    from     = number
    to       = number
    protocol = string
  }))
  default = [
    {
      desc     = "WEB HTTP Inbound"
      cidrs    = ["0.0.0.0/0"]
      from     = 80
      to       = 80
      protocol = "tcp"
    } 
  ]
}

variable "source_was_cidrs" {
  type = list(object({
    desc     = string
    cidrs    = list(string)
    from     = number
    to       = number
    protocol = string
  }))
  default = [
    {
      desc     = "WAS HTTP Inbound"
      cidrs    = ["0.0.0.0/0"]
      from     = 8080
      to       = 8080
      protocol = "tcp"
    } 
  ]
}