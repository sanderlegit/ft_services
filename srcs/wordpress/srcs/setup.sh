#!/bin/bash
# configure for DB
. /tmp/get_external_ip.sh WPSVC_IP wordpress-svc
envsubst '${WPSVC_IP} ${DB_NAME} ${DB_USER} ${DB_PASSWORD} ${DB_HOST}' < /tmp/wp-config.php > /www/wp-config.php
rm /tmp/wp-config.php
# set permissions for wp-cli, add to path
chmod +x /tmp/wp-cli.phar
mv /tmp/wp-cli.phar /usr/local/bin/wp
# run install/test shell
su www -c "/tmp/wpinstall.sh"
# clean
rm -rf /root/.wp-cli
