provider "aws" {

  region = "ap-south-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    name = "test"
}
}

resource "aws_subnet" "vpc_subnet" {
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = "10.10.3.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    name = "test"
}
}

resource "aws_instance" "test" {
   ami = "ami-076e3a557efe1aa9c"
   subnet_id = aws_subnet.vpc_subnet.id
   instance_type = "t2.micro"

   tags = {
    name = "prod"
}
}
