```
sudo dnf update -y
sudo dnf install python3 -y
python3 --version
sudo dnf install python3-pip -y
sudo dnf install ansible -y
sudo pip3 install ansible

sudo mkdir -p /etc/ansible/aws
sudo mkdir -p /etc/ansible/inventory
sudo mkdir -p /etc/ansible/playbooks

sudo touch /etc/ansible/aws/ansible.pem

ansible --version

sudo dnf install tree -y
tree --version

cd /etc/ansible

sudo nano inventory/hosts

[all]
52.91.206.22
184.73.112.69

sudo nano ansible.cfg
ansible -m ping all
```
