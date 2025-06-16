terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "main" {
    ami = "ami-0f918f7e67a3323f0"
    instance_type = "t2.medium"
    vpc_security_group_ids = [ aws_security_group.main.id ]
    key_name = "key"
    user_data = templatefile("./install.sh", {})
    tags = {
        Name = "Swiggy-DevOps-Project"
    }
    root_block_device {
        volume_size = 20
        volume_type = "gp2"
    }
  
}

resource "aws_security_group" "main" {
    name        = "swiggy-devops-sg"
    description = "Security group for Swiggy DevOps project"
    
   ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}