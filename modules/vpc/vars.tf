variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "default"
}

variable "vpc_id" {}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ingressCIDRblock" {
    type = list
    default = [ "0.0.0.0/0","111.92.89.100/32" ]
}