#!/bin/bash
#sudo apt-get update -y 
#sudo apt install apache2 -y
#sudo systemctl start apache2
#sudo systemctl status apache2

sudo su -
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
echo '<center><h1> Dianas EC2 instance located in Availability Zone: AZID </h1></center>' > /var/www/html/index.txt
sed -i "s/AZID/$EC2AZ/" /var/www/html/index.txt > /var/www/html/index.html
cat /var/www/html/index.txt > /var/www/html/index.html