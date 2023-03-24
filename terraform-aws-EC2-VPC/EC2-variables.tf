variable "ec2_tags" {
    type = map(string)
    default = {
      "Name" = "EC2"
    }
  
}

variable "ec2_ami" {
    type = string
    default = "ami-02f3f602d23f1659d"
  
}

variable "ec2_instance_type" {
    type = string
    default = "t2.micro"
  
}

variable "instance_count" {
  description = "AWS  Instances Count"
  type = number
  default = 2
}

variable "instance_keypair" {
  description = "AWS EC2 Key pair that need to be associated with EC2 Instance"
  type = string
  default = "terraform-key"
}