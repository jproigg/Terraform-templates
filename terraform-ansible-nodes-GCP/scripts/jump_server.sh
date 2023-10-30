#!/bin/bash
sudo useradd devopsadmin -s /bin/bash -m -d /home/devopsadmin  -p $(openssl passwd -1 devopsadmin) && \

sudo echo 'devopsadmin ALL=(ALL) NOPASSWD: /bin/su' | sudo EDITOR='tee -a' visudo && \

#Enable password authentication to yes and reload the sshd service
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config && \ 
service ssh reload && \

#switch user and create ssh key
sudo su - devopsadmin -c 'ssh-keygen -t rsa -b 2048 -N "" -m "PEM" -f ~/.ssh/jumpkey'

