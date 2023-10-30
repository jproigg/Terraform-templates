#!/bin/bash

# Install Ansible
sudo -i && \
sudo apt update -y && \
sudo apt install software-properties-common -y && \
sudo add-apt-repository --yes --update ppa:ansible/ansible && \
sudo apt update -y && \
sudo apt install ansible -y && \

#Create Ansible user on Ansible controller node
sudo useradd ansible -s /bin/bash -m -d /home/ansible -p $(openssl passwd -1 ansible) && \
sudo chown -R ansible:ansible /etc/ansible && \

#Enable password authentication to yes and reload the sshd service
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
sudo sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \ 
service ssh reload && \ 


#login without password to ansible user and create ssh key without passphrase
sudo echo 'ansible ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo && \
sudo echo 'ansible ALL=(ALL) NOPASSWD: /bin/su' | sudo EDITOR='tee -a' visudo && \
sudo su - ansible -c 'ssh-keygen -t rsa -b 2048 -N "" -m PEM -f ~/.ssh/id_rsa' 





