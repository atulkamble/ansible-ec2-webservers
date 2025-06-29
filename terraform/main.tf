# VPC
resource "aws_vpc" "ansible_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "ansible-vpc"
  }
}

# Subnet
resource "aws_subnet" "ansible_subnet" {
  vpc_id            = aws_vpc.ansible_vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "ansible-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ansible_vpc.id

  tags = {
    Name = "ansible-igw"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.ansible_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.ansible_subnet.id
  route_table_id = aws_route_table.rt.id
}

# Security Group
resource "aws_security_group" "ansible_sg" {
  name        = "ansible-sg"
  description = "Allow SSH, HTTP, HTTPS"
  vpc_id      = aws_vpc.ansible_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-sg"
  }
}

# Ansible Server Instance
resource "aws_instance" "ansible_server" {
  ami                         = "ami-05ffe3c48a9991133" # Amazon Linux 2023 us-east-1
  instance_type               = var.instance_type_ansible
  subnet_id                   = aws_subnet.ansible_subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  associate_public_ip_address = true

  user_data = file("userdata/ansible-server.sh")

  tags = {
    Name = "ansibleserver"
  }
}

# Host1 Instance
resource "aws_instance" "host1" {
  ami                         = "ami-05ffe3c48a9991133"
  instance_type               = var.instance_type_host
  subnet_id                   = aws_subnet.ansible_subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  associate_public_ip_address = true

  user_data = file("userdata/host.sh")

  tags = {
    Name = "host1"
  }
}

# Host2 Instance
resource "aws_instance" "host2" {
  ami                         = "ami-05ffe3c48a9991133"
  instance_type               = var.instance_type_host
  subnet_id                   = aws_subnet.ansible_subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.ansible_sg.id]
  associate_public_ip_address = true

  user_data = file("userdata/host.sh")

  tags = {
    Name = "host2"
  }
}
