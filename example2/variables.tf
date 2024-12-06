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
