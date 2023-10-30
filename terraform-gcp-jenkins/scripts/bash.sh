#!/bin/bash

# Step 1: Update the package list
sudo apt update

# Check if the update was successful (exit code 0 indicates success)
if [ $? -eq 0 ]; then
# Step 2: Install Docker
sudo apt install docker.io -y

# Check if the installation was successful
if [ $? -eq 0 ]; then
    # Step 3: Create a Docker volume for Jenkins data
    sudo docker volume create jenkins_data

    # Check if the volume creation was successful
    if [ $? -eq 0 ]; then
    # Step 4: Run the Jenkins container
    sudo docker run -d -p 8080:8080 --name jenkins -v jenkins_data:/var/jenkins_home jenkins/jenkins:lts

    # Check if the container is running (exit code 0 indicates success)
    if [ $? -eq 0 ]; then
        echo "Jenkins is up and running!"
    else
        echo "Failed to start Jenkins container."
    fi
    else
    echo "Failed to create Jenkins data volume."
    fi
else
    echo "Failed to install Docker."
fi
else
echo "Failed to update the package list."
fi