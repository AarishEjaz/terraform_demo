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

