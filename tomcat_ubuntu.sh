#!/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install openjdk-8-jdk -y
sudo apt install tomcat8 tomcat8-admin tomcat8-docs tomcat8-common git -y




sudo apt install awscli -y
aws s3 cp s3://vprofile-artifact-storage-bucket-4523/vprofile-v2.war /tmp/vprofile-v2.war
cd /var/lib/tomcat8/webapps/
sudo systemctl stop tomcat8
sudo rm -rf ROOT
sudo cp /tmp/vprofile-v2.war /var/lib/tomcat8/webapps/ROOT.war
sudo systemctl start tomcat8
