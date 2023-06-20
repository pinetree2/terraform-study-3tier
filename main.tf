
// provider는 module을 당겨온 쪽에서 정의합니다.
provider "aws" {
  region = "ap-northeast-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
    source = "./modules/vpc"
    #변수 작성 - vpc 하나만들거라 따로 변수 지정안함
    
}
