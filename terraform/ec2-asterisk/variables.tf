# ─────────────────────────────────────────────
# FILE: variables.tf
# ─────────────────────────────────────────────

# variables.tf

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "archit-vpc"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "voip-subnet"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
  default     = "voip-igw"
}

variable "route_table_name" {
  description = "Name of the Route Table"
  type        = string
  default     = "voip-rt"
}

variable "key_name" {
  description = "Name of the key pair"
  type        = string
  default     = "ec2-mum-key.pem"
}

variable "public_key_path" {
  description = "Path to the public key"
  type        = string
  default     = "/home/archit/.ssh/id_rsa.pub"
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "asterisk-sg"
}

variable "sg_description" {
  description = "Description of the security group"
  type        = string
  default     = "Allow SSH and SIP"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Ubuntu 22.04)"
  type        = string
  default     = "ami-0fc682b3f0e1487f0" # Update to latest AMI if needed
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3a.small"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "asterisk-instance"
}

variable "ebs_volume_size" {
  description = "Size of the EBS root volume in GB"
  default = 20
}

variable "kms_key_id" {
  description = "KMS key ID for EBS encryption (optional). Leave blank to use AWS-managed key"
  type        = string
  default     = ""  # leave empty to use the default AWS-managed KMS key
}