
// provider는 module을 당겨온 쪽에서 정의합니다.
provider "aws" {
  region = "ap-northeast-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source = "./modules/vpc"
    #변수 작성 - vpc 하나만들거라 따로 변수 지정안함
    tag = "song"
}

module "ec2" {
  source = "./modules/ec2"
  sg_id = module.sg.sg_id
  public_subnet_id = module.vpc.public_subnet_id[0]
  private_subnet_id = [module.vpc.private_subnet_id[0],module.vpc.private_subnet_id[1],module.vpc.private_subnet_id[2],module.vpc.private_subnet_id[3]]

}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id =module.vpc.vpc_id
  security_group_id = module.sg.sg_id
  #output 에 선언해놓은 값 
  private_subnet_id = [module.vpc.private_subnet_id[0],module.vpc.private_subnet_id[1]]
  private_instance_id = [module.ec2.private_instance_id[0],module.ec2.private_instance_id[1]]
}

module "rds" {
  source = "./modules/rds"
  sg_id = module.sg.sg_id
  vpc_id = module.vpc.vpc_id
  tag = "song"
}