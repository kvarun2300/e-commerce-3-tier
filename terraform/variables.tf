variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "ecommerce-eks"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "db_username" {
  type    = string
  default = "ecommerce"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "eks_node_instance_type" {
  type    = string
  default = "t3.medium"
}
