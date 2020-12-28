#!/bin/bash
#get wp install archive
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#nginx permissiosn
chown -R www:www /var/lib/nginx
chown -R www:www /www
#find external IP
. /tmp/get_external_ip.sh WPSVC_IP wordpress-svc
#set enviroment supplied by .yaml secrets
envsubst '${WPSVC_IP} ${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST}' < /tmp/wp-config.php > /www/wp-config.php
#remove template file
rm /tmp/wp-config.php
#set permissions
chmod +x wp-cli.phar
#add to path
mv wp-cli.phar /usr/local/bin/wp
#run install/test shell
cd /www
su www -c "/tmp/wpinstall.sh"
#clean
rm -rf /root/.wp-cli
