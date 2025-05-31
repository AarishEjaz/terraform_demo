variable "instance_config" {
    type = object({
      ami_id = string,
      instance_type = string,
      instance_count = number,
      instance_name = string,
      # aws_region = string
    })
    # default = {
    #   ami_id = "ami-0af9569868786b23a"
    #   instance_type = "t2.micro"
    #   instance_count = 2
    #   instance_name = "My tf instance"
    #   # aws_region = "ap-south-1"
    # }
}

variable "environment" {
  type = string
  
}

# variable "vpc_config" {
#   type = object({
#     vpc_id = string
#     subnet_id = string
#   })
# }

# variable "alarm_config" {
#     type = object({
#       alarm_name = string,
#       comparison_operator = string,
#       evaluation_periods = number,
#       metric_name = string,
#       namespace = string,
#       period = number,
#       statistic = string,
#       threshold = number,
#       alarm_description = string,
#       alarm_actions = list(string),
#       dimensions = map(string)
#     })
  
# } 




variable "security_group_name" {
    type = string
    default = "Terraform-created-group"
    description = "number of instances"
  
}

variable "aws_region" {
    type = string
    default = "ap-south-1"
    description = "number of instances"
  
}

