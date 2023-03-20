variable "region" {
    description = "AWS region"
    
}

variable "ec2-tags" { 

    description = "tags"
    type = map(string)
  
}