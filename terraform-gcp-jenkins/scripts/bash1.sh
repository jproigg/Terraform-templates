#!/bin/bash

# Install Java
sudo apt update -y && \
sudo apt install openjdk-11-jre -y && \
java -version && \

# Install Git
sudo apt install git -y && \

# Install Maven
sudo apt install maven -y && \

# Create a user in the managed node
sudo useradd -s /bin/bash -m -d /home/devopsadmin devopsadmin && \

# Switch to the newly created user
sudo su - devopsadmin && \

# Create an SSH key
ssh-keygen -t rsa -b 4096 -N "" -m PEM -f "/home/devopsadmin/.ssh/id_rsa" && \
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys && \

# Change ownership and permissions for SSH keys
chown -R devopsadmin ~/.ssh && \
chmod 600 ~/.ssh/authorized_keys && \
chmod 700 ~/.ssh



