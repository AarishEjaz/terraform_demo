provider "aws"{
    region = "ap-south-1"
}

module "TerraformVPC" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = true
    tags = {name: "Terraform Vpc"}
  }

  subnet_config = {
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
    map_aws_public_ip_on_launch = true

  }

}


module "WebServer" {
    source = "./modules/ec2"

    instance_config = {
      ami_id = var.instance_config.ami_id 
      instance_type = var.instance_config.instance_type
      instance_count = var.instance_config.instance_count
      instance_name =  "WebServer-${var.instance_config.instance_name}" 
    }
    security_group_name = "Modified_security_config for Webserver"

  

    vpc_config = {
      vpc_id = module.TerraformVPC.vpc_id
      subnet_id = module.TerraformVPC.subnet_id
    }
  
}

resource "aws_sns_topic" "alarms" {
  name = "${terraform.workspace}-alarms"
}

module "webserver_cpu_alarm" {
  source = "./modules/cloudwatch"
  count = var.environment == "prod"?var.instance_config.instance_count:0
  alarm_config = {
    alarm_name = "${terraform.workspace}-webserver-high-cpu-${count.index + 1}"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = 5
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = 60
    statistic = "Average"
    threshold = 5
    alarm_description = "Test monitor created for prod resources"
    alarm_actions = [aws_sns_topic.alarms.arn]

    dimensions = {
      InstanceId = module.WebServer.instance_id[count.index]
    }

  }

  
  
}

module "BackendServer" {
    source = "./modules/ec2"

    instance_config = {
      ami_id = var.instance_config.ami_id
      instance_type = var.instance_config.instance_type
      instance_count = var.instance_config.instance_count
      instance_name =  "BackendServer-${var.instance_config.instance_name}" 
    }

    security_group_name = "Modified_security_config for Backendserver"
    vpc_config = {
      vpc_id = module.TerraformVPC.vpc_id
      subnet_id = module.TerraformVPC.subnet_id
    }
}

# module "WebServer_security" {
#     source = "./modules/ec2"
#     instance_count = 1
#     instance_name =  "My TF web server"
  
# }

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
# resource "aws_s3_bucket" "example" {
#     bucket = "my-aarish-tf-test-bucket"

#     tags = {
#         Name = "My bucket"
#         Environment = "Dev"
#     }
  
# }

# # Adding security group ---------------------------------------------------------
# resource "aws_security_group" "example" {
#   # ... other configuration ...
#   name = "terraform_allow_group"
#   description = "allowing traffic to instances"

#   ingress {
#     from_port = 8080
#     to_port = 8080
#     protocol = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]    

#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "Allowing the traffic via terraform config"
#   }
# }

# # Creating Dynamo db table ------------------------------------------------------------
# resource "aws_dynamodb_table" "basic-dynamodb-table" {
#   name           = "terraform-lock"
#   billing_mode   = "PAY_PER_REQUEST"
#   # read_capacity  = 20
#   # write_capacity = 20
#   hash_key       = "LockID"
#   # range_key      = "GameTitle"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }


# }


# Backend --------------------------------------------------------
# terraform {
#   backend "s3" {
#     bucket = "my-aarish-tf-test-bucket"
#     region = "ap-south-1"
#     # key = "db"
#     # use_lockfile = true
#     # dynamodb_table = "terraform-lock"
    
#   }
# }