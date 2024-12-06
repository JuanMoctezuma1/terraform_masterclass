##Locals##
locals {
  common_tags = {
    Environment = "Production"
    Team        = "DevOps"
    Name        = "Test-${var.instance_name}"
  }
  Service_name = "Web_server"
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
