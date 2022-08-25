provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "dummy" {
  ami           = "ami-076e3a557efe1aa9c"
  instance_type = "t2.micro"


tags = {
 name       = "instance"
 envirnment = "test"

}
} 
