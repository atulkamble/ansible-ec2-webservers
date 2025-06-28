```
sudo dnf update -y
sudo dnf install python -y
sudo dnf install pip -y
sudo dnf install ansible -y
cd /etc/ansible
sudo mkdir aws/aws_keys
sudo touch ansible.pem
sudo mkdir inventory
sudo mkdir playbooks
sudo nano inventory/hosts

[all]
52.91.206.22
184.73.112.69

sudo nano ansible.cfg
ansible -m ping all
```
