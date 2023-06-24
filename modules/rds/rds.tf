
locals {
  master_az = "ap-northeast-2a" # 마스터 인스턴스를 생성할 가용영역
  slave_az  = "ap-northeast-2c" # 슬레이브 인스턴스를 생성할 가용영역
}

resource "aws_db_subnet_group" "subnet_group"{
    name = "song-db-master-subnet-group"
    subnet_ids = [aws_subnet.db_subnet[0].id,aws_subnet.db_subnet[1].id]

    tags ={
        Name = "Song DB master Subnet Group"

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

resource "aws_db_instance" "rds_master" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.t2.micro"
  multi_az               = true
  //availability_zone = local.master_az
  //subnet_ids = [aws_subnet.db_subnet[0].id]
  identifier             = "master-db"
  username               = "root"
  password               = "12345678"
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.sg_id]

}

resource "aws_db_instance" "rds_slave" {

  count =1
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = "db.t2.micro"
  multi_az               = true
  //availability_zone = local.slave_az
  //subnet_ids = [aws_subnet.db_subnet[0].id]
  identifier             = "slave-db"
  username               = "root"
  password               = "12345678"
  skip_final_snapshot    = true
  vpc_security_group_ids = [var.sg_id]

}