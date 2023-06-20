#public subnet 에 ec2생성 - bastion 
resource "aws_instance" "basti-instance"{

    ami = ""
    instance_type = var.default_instance_type
    key_name = var.key_pair
    vpc_security_group_ids = ["${module.security_group.security_group_id}"]
    subnet_id = "${module.vpc.aws_subnet.public_subnet.id[0]}"
    //associate_public_ip_address = true
    //user_data = 

    tags = {
    Name = "song - bastion Public Instance"
  }
}



#private subnet 에 ec2 생성 - web,was 용 각2개 총 4개

