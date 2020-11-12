service mysql start

# change access
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

# Set ssl key 
mkdir /set_file/ssl
openssl req -new -newkey rsa:2048 -nodes -subj '/C=KR/ST=S/L=S/O=S/CN=seolim' -keyout /set_file/ssl/ft_server.key -out /set_file/ssl/ft_server.csr
openssl x509 -req -days 365 -in /set_file/ssl/ft_server.csr -signkey /set_file/ssl/ft_server.key -out /set_file/ssl/ft_server.crt

# Set php file and conf
echo "<?php phpinfo(); ?>" > /var/www/html/index.php
cp /set_file/default /etc/nginx/sites-available/
rm /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Set php admin
mkdir /var/www/html/phpMyAdmin
tar -xvf /set_file/phpMyAdmin-4.9.4-all-languages.tar.gz --strip-components 1 -C /var/www/html/phpMyAdmin
cp /set_file/config.inc.php /var/www/html/phpMyAdmin

# Set php wordpress
tar -xvzf /set_file/latest.tar.gz -C /var/www/html/
cp /set_file/wp-config.php /var/www/html/wordpress/

mysql -u root --skip-password < /set_file/set_sql

service php7.3-fpm start
service nginx start

while true;
    do sleep 10000;
done