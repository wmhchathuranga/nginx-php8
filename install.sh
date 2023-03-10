#!/bin/bash

echo -e "\n\nUpdating Apt Packages\n"

yes '' | sudo add-apt-repository ppa:ondrej/php 

sudo apt-get update && sudo apt-get upgrade -y 

sudo apt-get install software-properties-common -y

echo -e "\n\nInstalling Nginx Web server\n"

sudo apt install nginx -y

sudo systemctl start nginx
sudo systemctl enable nginx

unlink /etc/nginx/sites-enabled/default

rm /etc/nginx/sites-available/default

mv default /etc/nginx/sites-available/

ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

echo -e "\n\nInstalling PHP & Requirements\n"

sudo apt install php8.0-fpm php8.0-common php8.0-mysql php8.0-gmp php8.0-curl php8.0-intl php8.0-mbstring php8.0-xmlrpc php8.0-gd php8.0-xml php8.0-cli php8.0-zip -y

echo -e "\n\nInstalling MySQL\n"

sudo apt-get install mysql-server mysql-client -y

sudo systemctl start mysql
sudo systemctl enable mysql

echo -e "\n\nRestarting Nginx\n"

sudo systemctl restart nginx

echo -e "\n\nInstalling Unzip\n"

sudo apt-get install unzip

echo -e "\n\nDownloading phpMyadmin & Unzip phpMyadmin\n"

sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-english.zip && mv phpMyAdmin-5.2.0-english.zip /var/www/html

sudo unzip /var/www/html/phpMyAdmin-5.2.0-english.zip -d /var/www/html

sudo mv /var/www/html/phpMyAdmin-5.2.0-english /var/www/html/phpmyadmin

rm /var/www/html/phpMyAdmin-5.2.0-english.zip 

echo -e "\n\nCreating MySQL user and database\n"

mysql -u root <<EOF
CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '1SqQhTi%4V7zwf^X';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost';
FLUSH PRIVILEGES;
EOF

mkdir /var/www/html/phpmyadmin/tmp && chmod 777 /var/www/html/phpmyadmin/tmp

mv config.inc.php /var/www/html/phpmyadmin/

echo -e "\n\nDone and Dusted\n"
