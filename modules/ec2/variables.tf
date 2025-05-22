variable "instance_config" {
    type = object({
      ami_id = string,
      instance_type = string,
      instance_count = number,
      instance_name = string
    })
}

variable "ami_id" {
    type = string
    default = "ami-0af9569868786b23a"
    description = "This is the ami id "

}

variable "instance_type" {
    type = string
    default = "t2.micro"
    description = "Type of EC2 instance to be launched"
  
}

variable "instance_count" {
    type = number
    default = 2
    description = "number of instances"
  
}

variable "instance_name" {
    type = string
    default = "Terraform-created"
    description = "number of instances"
  
}

variable "aws_region" {
    type = string
    default = "ap-south-1"
    description = "number of instances"
  
}

variable "ingress_ports" {
    type = list(number)
    description = "list of ingress ports to be added"
    default = [ 22,80,443,8080,3000,8000 ]
}

variable "security_group_name" {
    type = string
    default = "Terraform-created-group"
    description = "number of instances"
  
}