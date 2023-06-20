resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc-${var.tag}"
  }
}

#igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-${var.tag}"
  }
}


#public subnet - igw 와 연결
resource "aws_subnet" "public_subnet"{
  count =2
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = var.available_azs[count.index]
  tags = {
    Name = "${var.tag}-subnet-pub-${count.index +1}"
  }
  
}

#private subnet - natgw 연결 
resource "aws_subnet" "private_subnet"{
  count = 6
  vpc_id = aws.vpc.vpc.id
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = var.available_azs[count.index % length(var.available_azs)]
  tags = {
    Name = "${var.tag}-subnet-pri-${count.index +1}"
  }
}

//create route table
resource "aws_route_table" "route_table_pub"{
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "{var.tag}-pub-route"
  }
}

//associate route table
resource "aws_route_table_association" "route_table_association-1"{
  count = 2
  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.route_table_pub.id
}

//nat gw 를 위한 EIP 발급
resource "aws_eip" "nat-eip"{
  vpc = true 
  lifecycle{
    create_before_destroy = true
  }
}

// eip 할당 , nat 연결
resource "aws_nat_gateway" "nat_gw"{
  allocation_id = aws_eip.nat-eip.id
  subnet_id = aws_subnet.public_subnet[0].id
  tags = {
    Name = "NAT_GW-${var.tag}"
  }
}
