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

resource "aws_security_group" "test" {
  name = "test"
  vpc_id = aws_vpc.test_vpc.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "test" {
   ami = "ami-076e3a557efe1aa9c"
   subnet_id = aws_subnet.vpc_subnet.id
   instance_type = "t2.micro"
   vpc_security_group_ids = [aws_security_group.test.id]

   tags = {
    name = "prod"
}
}

output "aws_instance_private_ip" {
  value = aws_instance.test.private_ip
}

output "aws_security_group_name" {
  value = aws_security_group.test.id

}
