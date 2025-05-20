provider "aws" {
    region = var.aws_region
  
}

resource "aws_instance" "terraform-ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    count = var.instance_count
    
  tags = {
    Name = var.instance_name
  }
  
}