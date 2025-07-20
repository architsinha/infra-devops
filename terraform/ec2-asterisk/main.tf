# ─────────────────────────────────────────────
# Terraform to launch Ubuntu 22.04 EC2 for Asterisk Dev/Prod - Modular Setup
# ─────────────────────────────────────────────

# FILE: main.tf

# main.tf
provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "asterisk_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Subnet
resource "aws_subnet" "asterisk_subnet" {
  vpc_id            = aws_vpc.asterisk_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = var.availability_zone
  tags = {
    Name = var.subnet_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.asterisk_vpc.id
  tags = {
    Name = var.igw_name
  }
}

# Route Table
resource "aws_route_table" "asterisk_rt" {
  vpc_id = aws_vpc.asterisk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

# Route Table Association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.asterisk_subnet.id
  route_table_id = aws_route_table.asterisk_rt.id
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# Security Group
resource "aws_security_group" "asterisk_sg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_vpc.asterisk_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SIP Port (example)"
    from_port   = 5060
    to_port     = 5061
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}

terraform {
  backend "s3" {}
}

# EC2 Instance
resource "aws_instance" "asterisk" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.asterisk_subnet.id
  vpc_security_group_ids = [aws_security_group.asterisk_sg.id]
  key_name               = aws_key_pair.deployer.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.ebs_volume_size
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = var.kms_key_id  # optional, uses default KMS if not set
  }

  tags = {
    Name = var.instance_name
  }
}
