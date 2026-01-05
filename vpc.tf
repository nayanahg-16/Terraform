provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
    tags = {
        name = "myvpc"
    }
  
}

resource "aws_subnet" "mysubnet1" {
    vpc_id = aws_vpc.myvpc.id
    
    cidr_block = "10.0.1.0/24" 
    availability_zone       = "us-east-1a" 
    tags = {
        name = "mysubnet1"
    }
}

resource "aws_subnet" "mysubnet2" {
    vpc_id = aws_vpc.myvpc.id
    
    cidr_block              = "10.0.2.0/24"       # Different CIDR from subnet1
    availability_zone       = "us-east-1b" 

    tags = {
        name = "mysubnet2"
    }
}

resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
        name = "myigw"
    }
}

resource "aws_route_table" "myrt" {
    vpc_id = aws_vpc.myvpc.id
    

    tags = {
        name = "myrt"
    }
}

resource "aws_route" "publicrt" {
    gateway_id = aws_internet_gateway.myigw.id
   destination_cidr_block = "0.0.0.0/0"
    route_table_id = aws_route_table.myrt.id
  
}

resource "aws_route_table_association" "subnet1rt" {
    subnet_id = aws_subnet.mysubnet1.id
    route_table_id = aws_route_table.myrt.id

  
}

resource "aws_route_table_association" "subnet2rt" {
    subnet_id = aws_subnet.mysubnet2.id
    route_table_id = aws_route_table.myrt.id

  
}

