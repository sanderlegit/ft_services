#configuring for DB
. /tmp/get_external_ip.sh PHPSVC_IP phpmyadmin-svc
envsubst '${PHPSVC_IP} ${DB_HOST}' < /tmp/config.inc.php > /www/config.inc.php
#phpmyadmin page
tar -xzvf /tmp/phpMyAdmin-5.0.1-english.tar.gz --strip-components=1 -C /www
chmod 777 /tmp/
