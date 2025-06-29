variable "key_name" {
  description = "Key pair for EC2 instances"
  default     = "ansible"
}

variable "instance_type_ansible" {
  default = "t3.medium"
}

variable "instance_type_host" {
  default = "t3.micro"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}
