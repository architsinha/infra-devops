aws_region        = "ap-south-1"
vpc_cidr          = "10.1.0.0/16"
vpc_name          = "archit-mum-vpc"
subnet_cidr       = "10.1.1.0/24"
availability_zone = "ap-south-1a"
subnet_name       = "mum-voip-subnet"
igw_name          = "mum-igw"
route_table_name  = "mum-rt"
key_name          = "ec2-mum-key.pem"
public_key_path   = "/home/archit/.ssh/id_rsa.pub"
sg_name           = "mum-sg"
sg_description    = "Allow SSH and SIP for Dev"
ami_id            = "ami-021a584b49225376d"
instance_type     = "t3a.small"
instance_name     = "asterisk-dev-instance"
ebs_volume_size   = 20
kms_key_id        = ""