# vpc_module.tf

# Variables

variable "vpc_name"{}
variable "vpc_cidr_block" {}
variable "subnet_app_cidr_block" {}
variable "subnet_db_cidr_block" {}
variable "subnet_app_zone" {}
variable "subnet_db_zone" {}
variable "subnet_db_name" {}
variable "subnet_app_name" {}
variable "igw_name" {}
variable "routeable_name" {}
# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

# Subnets
resource "aws_subnet" "subnet_app_name" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_app_cidr_block
  availability_zone = var.subnet_app_zone  # Modify this according to your preference

  tags = {
    Name = var.subnet_app_name
  }
}

resource "aws_subnet" "subnet_db_name" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_db_cidr_block
  availability_zone = var.subnet_db_zone  # Modify this according to your preference

  tags = {
    Name = var.subnet_db_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.routeable_name
  }
}

# Associate Route Table with Subnets
resource "aws_route_table_association" "subnet_app_name_association" {
  subnet_id      = aws_subnet.subnet_app_name.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_db_name_association" {
  subnet_id      = aws_subnet.subnet_db_name.id
  route_table_id = aws_route_table.public.id
}

