data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  name = "${var.project_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.0"

  name               = var.project_name
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      instance_types = [var.eks_node_instance_type]
      min_size       = 2
      max_size       = 3
      desired_size   = 2
    }
  }
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  identifier = "${var.project_name}-mysql"

  engine               = "mysql"
  engine_version       = "8.0"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"

  allocated_storage = 20
  storage_encrypted = true

  db_name  = "ecommerce"
  username = var.db_username
  password = var.db_password
  port     = 3306

  multi_az               = false
  publicly_accessible    = false
  create_db_subnet_group = true
  subnet_ids              = module.vpc.private_subnets

  vpc_security_group_ids = [aws_security_group.rds.id]

  backup_retention_period = 7
  deletion_protection     = false
  skip_final_snapshot     = true
}
