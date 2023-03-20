resource "aws_instance" "web" {
  ami           = "ami-0f3c9c466bb525749"
  instance_type = "t2.micro"
  count = 1

  tags = var.ec2-tags
}