output "instance_id" {
    description = "This is the id of ec2 instances"
    value = aws_instance.terraform-ec2[0].id
  
}

output "public_ip" {
    description = "This is the public ip of ec2 instances"
    value = aws_instance.terraform-ec2[0].public_ip
  
}

output "pubilc_dns" {
    description = "This is the id of ec2 instances"
    value = aws_instance.terraform-ec2[0].public_dns
  
}