
module "ec2_public" {
  depends_on = [ module.vpc ] 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.17.0"
  name                   = "vm"
  ami                    = var.ec2_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.instance_keypair
  vpc_security_group_ids = [module.public_sg.this_security_group_id]
  subnet_ids = [
    module.vpc.public_subnets[0],
    module.vpc.public_subnets[1]
  ]  
  instance_count         = var.instance_count
  user_data = file("${path.module}/app1-install.sh")
  tags = local.common_tags
}

