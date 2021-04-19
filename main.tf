variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {}
variable "region" {
  default = "us-east-2"
  
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}
provider "aws" {

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  alias   = "east1"
  region = "us-east-1"
}
provider "aws" {

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  alias ="east2"
  region = "us-east-2"
}

module "my_vpc_1"  {
  source      = "./modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc_1.vpc_id}"
  subnet_cidr = "192.168.1.0/24" 

  providers = {
    aws = aws.east1
   }
}

module "my_ec2_1" {
  source        = "./modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-042e8287309f5df03"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc_1.subnet_id}"
  

  providers = {
    aws = aws.east1
   }
  
}

module "my_secgrp_1" {
  source        = "./modules/ec2"
  subnet_id     = "${module.my_vpc_1.subnet_id}"
  ami_id        = "ami-042e8287309f5df03"
  

  providers = {
    aws = aws.east1
   }
}

module "my_vpc_2"  {
  source      = "./modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc_2.vpc_id}"
  subnet_cidr = "192.168.1.0/24" 

  providers = {
    aws = aws.east2
   }
}

module "my_ec2_2" {
  source        = "./modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-08962a4068733a2b6"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc_2.subnet_id}"
   

  providers = {
    aws = aws.east2
   }
  
}

module "my_secgrp_2" {
  source        = "./modules/ec2"
  subnet_id     = "${module.my_vpc_2.subnet_id}"
  ami_id        = "ami-08962a4068733a2b6"
  

  providers = {
    aws = aws.east2
   }
}