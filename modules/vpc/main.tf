resource "aws_vpc" "terraform-created-vpc" {
  cidr_block = var.vpc_config.cidr_block
  instance_tenancy = var.vpc_config.instance_tenancy
  enable_dns_hostnames = var.vpc_config.enable_dns_hostnames

  tags = {
    Name = "tf-main"
  }

}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.terraform-created-vpc.id
    cidr_block = var.subnet_config.cidr_block
    availability_zone = var.subnet_config.availability_zone
  
}

resource "aws_internet_gateway" "terraform-gateway" {
  vpc_id = aws_vpc.terraform-created-vpc.id

  tags = {
    Name = "Terraform gateway" 
  }
}

resource "aws_route_table" "terraform-route_table"{
    vpc_id = aws_vpc.terraform-created-vpc.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform-gateway.id
    }

    tags = {
        Name = "Terraform route table"
    }  

}

resource "aws_route_table_association" "terraform-route_table_association" {
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.terraform-route_table.id
}