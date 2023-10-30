#!/bin/bash

#Create Ansible user on Ansible controller node
sudo apt update -y && \
sudo useradd ansible -s /bin/bash -m -d /home/ansible -p $(openssl passwd -1 ansible) && \

#Enable password authentication to yes and reload the sshd service
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
sudo sed -i 's/PubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config && \
service ssh reload && \

#Enable ansible usser to be like root
sudo echo 'ansible ALL=(ALL:ALL) NOPASSWD:ALL' | sudo EDITOR='tee -a' visudo && \

#login to ansible user without password
sudo echo 'ansible ALL=(ALL) NOPASSWD: /bin/su' | sudo EDITOR='tee -a' visudo 

