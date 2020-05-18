#!/bin/bash
yum install httpd git -y
systemctl start httpd
systemctl enable httpd
git clone https://github.com/iamsatya/digital.git
mv digital/* /var/www/html