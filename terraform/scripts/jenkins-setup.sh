#!/bin/bash

sudo yum install java-1.8.0 -y
sudo yum update –y
sudo yum install wget -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key

#Install jenkins package
sudo yum install jenkins -y

sudo chkconfig jenkins on

#Start Jenkins service
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.service

echo 'Jenkins fully setup' 

echo 'Jenkins admin password found in /var/lib/jenkins/secrets/initialAdminPassword'

