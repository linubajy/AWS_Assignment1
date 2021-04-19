

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
  alias  = "us-east-2"
  region = "us-east-2"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_instance" "my_ec2" {
  count         = "${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"

  tags = {
    Name = "new"
  }
}
