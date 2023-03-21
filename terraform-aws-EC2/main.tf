resource "aws_instance" "web" {
  ami           = "ami-02f3f602d23f1659d"
  instance_type = "t2.micro"
  count = 1

  tags = var.ec2-tags
}