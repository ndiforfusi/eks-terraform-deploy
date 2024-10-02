#!/bin/bash
# Install Java
sudo apt-get upgrade -y
sudo apt-get update && apt-get -y install openjdk-17-jdk wget
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins

# Start Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Intall nginx
sudo apt-get ngix

# Start nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

