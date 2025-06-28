
// ansible 

step 1) launch ansible host and server 
launch ec2 
count - 3
3 instances |

rename >> ansible-server | t3.medium 
rename >> host1, host2 >> 2 hosts | t3 micro 

vpc - subnet (same)
key - ansible.pem 
launch 

step 2) connect with server ec2 
cd Downloads
chmod 400 ansible.pem
ssh -i "ansible.pem" ec2-user@DNS

```
sudo dnf update -y
sudo dnf install tree -y
tree --version
sudo dnf install python -y
python --version
sudo dnf install pip -y
sudo dnf install python3-pip -y
sudo pip3 install ansible
sudo yum install ansible -y 
sudo dnf install ansible -y
sudo pip3 install ansible
ansible --version
sudo mkdir /etc/ansible
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
