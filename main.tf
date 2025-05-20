provider "aws"{
    region = "ap-south-1"
}


module "WebServer" {
    source = "./module/ec2"
    instance_count = 1
    instance_name =  "My TF web server"
  
}

# Launching EC2 instance --------------------------------------------------------
# resource "aws_instance" "terraform-ec2" {
    # ami = var.ami_id
    # instance_type = var.instance_type
    # count = var.instance_count
    # 
  # tags = {
    # Name = var.instance_name
  # }
  # 
# }

# Launching S3 bucket -----------------------------------------------------------
resource "aws_s3_bucket" "example" {
    bucket = "my-aarish-tf-test-bucket"

    tags = {
        Name = "My bucket"
        Environment = "Dev"
    }
  
}

# Adding security group ---------------------------------------------------------
resource "aws_security_group" "example" {
  # ... other configuration ...
  name = "terraform_allow_group"
  description = "allowing traffic to instances"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]    

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allowing the traffic via terraform config"
  }
}

# Creating Dynamo db table ------------------------------------------------------------
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  # read_capacity  = 20
  # write_capacity = 20
  hash_key       = "LockID"
  # range_key      = "GameTitle"

  attribute {
    name = "LockID"
    type = "S"
  }

  # ttl {
  #   attribute_name = "TimeToExist"
  #   enabled        = true
  # }

  # global_secondary_index {
  #   name               = "GameTitleIndex"
  #   hash_key           = "LockID"
  #   # range_key          = "TopScore"
  #   write_capacity     = 10
  #   read_capacity      = 10
  #   projection_type    = "INCLUDE"
  #   non_key_attributes = ["LockID"]
  # }

  # tags = {
  #   Name        = "dynamodb-table-1"
  #   Environment = "production"
  # }
}


# Backend --------------------------------------------------------
terraform {
  backend "s3" {
    bucket = "my-aarish-tf-test-bucket"
    region = "ap-south-1"
    # key = "db"
    # use_lockfile = true
    # dynamodb_table = "terraform-lock"
    
  }
}