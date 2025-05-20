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


# Adding security group --------------------------------------------------
resource "aws_security_group" "example" {
  # ... other configuration ...
  name = "terraform_allow_group"
  description = "allowing traffic to instances"

  dynamic "ingress" {
    for_each = var.ingress_ports
        content{
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks      = ["0.0.0.0/0"]
            ipv6_cidr_blocks = ["::/0"]  
        }
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