#######Versions##########
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


#######Providers##########
provider "aws" {
  region = "us-east-1"
}


#######Locals##########
locals {
  common_tags = {
    Environment = "Production"
    Team        = "DevOps"
    Name        = "Test-${var.instance_name}"
  }
  Service_name = "Web_server"
}


#######Data source##########
data "aws_security_group" "my_sg" {
  name = "test-security-group"
}




#######General example##########
resource "aws_instance" "app_server" {
  ami           = "ami-063d43db0594b521b"
  instance_type = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.my_sg.id]

  tags = local.common_tags
}


#######Count as conditional##########
resource "aws_instance" "ec2_count" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-063d43db0594b521b"
  instance_type = "t2.micro"
  tags = {
    Name        = "Conditional-ec2"
  }
}


#######Count as iterator simple example#########
resource "aws_instance" "example" {
  count         = var.number_of_instances
  ami           = "ami-063d43db0594b521b"
  instance_type = "t2.micro"
  tags = {
    Name = "Count-Instance-number-${count.index}"
  }
}


######Count as iterator in a list#########
resource "aws_instance" "ec2_count_list" {
  count         = length(var.instance_names)
  ami           = "ami-063d43db0594b521b"
  instance_type = "t2.micro"
  tags = {
    Name        = var.instance_names[count.index]
  }
}



#######Outputs##########
output "segurity_group" {
  description = "id of the security group"
  value = data.aws_security_group.my_sg.id
}

output "public_ip" {
  description = "Instance public IP"
  value = aws_instance.app_server.public_ip
}


#######Variables##########
variable "instance_type" {
  description = "Instance type we want to use"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Instance name we want to use"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "create_instance" {
  description = "bucket name we want to use"
  type        = bool
  default     = false
}

variable "number_of_instances" {
  description = "How many instances will be created using count"
  type    = number
  default = 3
}

variable "instance_names" {
  type    = list(string)
  default = ["web-server-1", "web-server-2", "web-server-3"]
}

