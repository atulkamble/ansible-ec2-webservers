Excellent request — let’s build clean, modular, production-grade Terraform code to launch:

* **1 Ansible Server (t3.medium)**
* **2 Hosts (t3.micro)**
* All in **us-east-1**
* Same **VPC, subnet, security group (allowing SSH/HTTP/HTTPS)**
* Same **keypair (ansible.pem)**
* Install **Ansible on AnsibleServer**

---

## 📂 Recommended Repo Structure:

```
terraform-ansible-setup/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── userdata/
    ├── ansible-server.sh
    └── host.sh
```

---

## 📦 Complete Terraform Code

---

### 📄 provider.tf

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

### 📄 variables.tf

```hcl
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
```

---

### 📄 main.tf

```hcl
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
  ami                         = "ami-0c101f26f147fa7fd" # Amazon Linux 2023 us-east-1
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
  ami                         = "ami-0c101f26f147fa7fd"
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
  ami                         = "ami-0c101f26f147fa7fd"
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
```

---

### 📄 outputs.tf

```hcl
output "ansible_server_public_ip" {
  value = aws_instance.ansible_server.public_ip
}

output "host1_public_ip" {
  value = aws_instance.host1.public_ip
}

output "host2_public_ip" {
  value = aws_instance.host2.public_ip
}
```

---

## 📄 userdata/ansible-server.sh

```bash
#!/bin/bash
sudo dnf update -y
sudo dnf install -y python3 python3-pip
sudo pip3 install ansible
sudo mkdir -p /etc/ansible
ansible --version
```

---

## 📄 userdata/host.sh

```bash
#!/bin/bash
sudo dnf update -y
sudo dnf install -y python3
```

---

## ✅ How to Deploy:

```bash
terraform init
terraform plan
terraform apply
```

---

## 📜 Notes:

* Replace **ami-0c101f26f147fa7fd** with latest Amazon Linux 2023 AMI ID in `us-east-1` as needed.
* Ensure **ansible.pem** keypair exists in the region.
* Security Group allows SSH (22), HTTP (80), HTTPS (443) for testing or configuration.
* Simple Ansible install via `user_data` on ansible-server.
* All public IPs exposed via `terraform output`.

---

Would you like me to package this into a downloadable repo archive as well? I can generate one for you.
