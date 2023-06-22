resource "aws_db_subnet_group" "default"{
    name = "song-db-subnet-group"
    subnet_ids = [aws_subnet.db_subnet[0].id,aws_subnet.db_subnet[1].id]
    tags ={
        Name = "Song DB Subnet Group"

    }
}


#private subnet - natgw 연결 
resource "aws_subnet" "db_subnet"{
  count = 2
  vpc_id = var.vpc_id
  cidr_block = var.db_subnet_cidr[count.index]
  availability_zone = var.available_azs[count.index % length(var.available_azs)]
  tags = {
    Name = "${var.tag}-db-pri-${count.index +1}"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "8.0.23"
  instance_class         = "db.t2.micro"
  multi_az               = true
  identifier             = "mydb"
  username               = "root"
  password               = "12345678"
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.sg_id]
}