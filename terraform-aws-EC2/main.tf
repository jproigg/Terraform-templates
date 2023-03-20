resource "aws_instance" "web" {
  ami           = "ami-05502a22127df2492"
  instance_type = "t2.micro"
  count = 4

  tags = var.ec2-tags
}