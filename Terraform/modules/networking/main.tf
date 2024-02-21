# ------------------------------------------------------------------------------
# AWS Networking module
# ------------------------------------------------------------------------------

// Local variables definition

locals {
  environment = "testing"
}

// VPC
resource "aws_vpc" "vpc" {

  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${local.environment}"
  }
}

// Public Subnets
resource "aws_subnet" "public_subnets" {

  vpc_id                  = aws_vpc.vpc.id
  for_each                = var.pub_subnets_cidr
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "pub-net-${each.key}"
  }
  depends_on = [aws_vpc.vpc]
}

// Internet Gateway
resource "aws_internet_gateway" "gw" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gw-${local.environment}"
  }
  depends_on = [aws_vpc.vpc]
}

// Routing tables
resource "aws_route_table" "rt" {

  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.routing_table_cird_block
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-${local.environment}"
  }
  depends_on = [aws_vpc.vpc]
}

# Routing table association
resource "aws_route_table_association" "public-rt-subnets" {
  for_each       = aws_subnet.public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
  depends_on     = [aws_subnet.public_subnets, aws_route_table.rt]
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_id" {
  value = values(aws_subnet.public_subnets)[*].id
}