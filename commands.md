```
# Update system packages
sudo dnf update -y

# Install Python (usually already present, but ensuring it)
sudo dnf install python3 -y

# Check Python version
python3 --version

# Install pip for Python 3
sudo dnf install python3-pip -y

# Install Ansible via DNF (preferred on modern RHEL/CentOS/Amazon Linux 2023)
sudo dnf install ansible -y

# OR, if required via pip (not recommended if dnf works fine)
# sudo pip3 install ansible

# Create necessary Ansible directory structure
sudo mkdir -p /etc/ansible/aws/aws_keys
sudo mkdir -p /etc/ansible/inventory
sudo mkdir -p /etc/ansible/playbooks

# Create your private key file
sudo touch /etc/ansible/aws/aws_keys/ansible.pem

# Check Ansible version
ansible --version

# Install tree utility for directory tree visualization
sudo dnf install tree -y

# Check tree version
tree --version

# Move into Ansible config directory
cd /etc/ansible

# Create your inventory hosts file
sudo nano inventory/hosts

[all]
52.91.206.22
184.73.112.69

sudo nano ansible.cfg
ansible -m ping all
```
