output "segurity_group" {
  description = "id of the security group"
  value = data.aws_security_group.my_sg.id
}

output "public_ip" {
  description = "Instance public IP"
  value = aws_instance.app_server.public_ip
}
