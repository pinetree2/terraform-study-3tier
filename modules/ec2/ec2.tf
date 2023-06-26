resource "aws_key_pair" "example" {
  key_name   =var.key_name
  public_key = file("../song-key.pub")
}



#public subnet 에 ec2생성 - bastion 
resource "aws_instance" "basti-instance"{

    ami = var.ami
    instance_type = var.instance_type
    //key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = ["${var.sg_id}"]
    subnet_id = var.public_subnet_id
    //associate_public_ip_address = true
    //user_data = 

    tags = {
    Name = "song - bastion Public Instance"
  }
}



#private subnet 에 ec2 생성 - web,was 용 각2개 총 4개

resource "aws_instance" "pri-instance"{
  ami = var.ami
  instance_type = var.instance_type
  count = 4
  //key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = ["${var.sg_id}"]
  subnet_id = var.private_subnet_id[count.index]

    tags = {
    Name = "private-song-instance-${count.index + 1}"
  }
}