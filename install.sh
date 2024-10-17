#!/bin/bash
set -e  # Exit immediately if any command fails
set -x  # Print each command before executing

sudo apt update

# Install Apache2
sudo apt install apache2 -y

# Install MySQL server
sudo apt install mysql-server -y

# Install PHP and required modules
sudo apt install php libapache2-mod-php php-mysql -y

# Check PHP version
php -v

# Restart Apache2 to apply changes
sudo systemctl restart apache2

# Install phpMyAdmin and other necessary PHP extensions
sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -y

# Enable mbstring PHP module
sudo phpenmod mbstring

# Restart Apache2 again to apply module changes
sudo systemctl restart apache2

# Add Include directive for phpMyAdmin in Apache2 configuration
echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf

# Restart Apache2 to apply the changes
sudo systemctl restart apache2

# Download and set up WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz

# Copy WordPress files to the web directory
sudo cp -R wordpress /var/www/html/

# Set proper ownership and permissions
sudo chown -R www-data:www-data /var/www/html/wordpress/
sudo chmod -R 755 /var/www/html/wordpress/

# Navigate to the WordPress directory
cd /var/www/html/wordpress
