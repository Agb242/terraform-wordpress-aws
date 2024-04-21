resource "aws_vpc" "infrastructure_vpc1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = "true" //gives you an internal domain name
  enable_dns_hostnames = "true" //gives you an internal host name
  #instance_tenancy     = "default"
  tags = {
    Name = "2-tier-architecture-vpc"
  }
}


# It enables our vpc to connect to the internet
resource "aws_internet_gateway" "tier_architecture_igw" {
  vpc_id = aws_vpc.infrastructure_vpc1.id
  tags = {
    Name = "2-tier-architecture-igw"
  }
}


# first ec2 instance public subnet
resource "aws_subnet" "ec2_1_public_subnet" {
  vpc_id                  = aws_vpc.infrastructure_vpc1.id
  cidr_block              = var.subnet_cidrs[1]
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability_zone[0]
  tags = {
    Name = "first ec2 public subnet"
  }
}


# second ec2 instance public subnet
resource "aws_subnet" "ec2_2_public_subnet" {
  vpc_id                  = aws_vpc.infrastructure_vpc1.id
  cidr_block              = var.subnet_cidrs[2]
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = var.availability_zone[0]
  tags = {
    Name = "second ec2 public subnet"
  }
}


# database private subnet
resource "aws_subnet" "database_private_subnet" {
  vpc_id                  = aws_vpc.infrastructure_vpc1.id
  cidr_block              = var.subnet_cidrs[4]
  map_public_ip_on_launch = "false" //it makes this a private subnet
  availability_zone       = var.availability_zone[0]
  tags = {
    Name = "database private subnet"
  }
}

