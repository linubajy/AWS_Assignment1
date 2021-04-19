variable "aws_access_key" {}
variable "aws_secret_key" {}
provider "aws" {

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-2"
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  alias  = "us-east-1"
  region = "us-east-1"
}