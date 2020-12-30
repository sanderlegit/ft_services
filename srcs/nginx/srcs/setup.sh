#!/bin/sh
# dynamic links to services, clean
. /tmp/get_external_ip.sh WORDPRESS_SVC wordpress-svc
. /tmp/get_external_ip.sh PHPMYADMIN_SVC phpmyadmin-svc
. /tmp/get_external_ip.sh GRAFANA_SVC grafana-svc
. /tmp/get_external_ip.sh NGINX_SVC nginx-svc
envsubst '${WORDPRESS_SVC} ${PHPMYADMIN_SVC} ${NGINX_SVC} ${GRAFANA_SVC}' < /tmp/index.html > /www/index.html
rm /tmp/index.html
envsubst '${WORDPRESS_SVC} ${PHPMYADMIN_SVC} ${NGINX_SVC}' < /tmp/default.conf > /etc/nginx/conf.d/default.conf
rm /tmp/default.conf
# ssh user
adduser --disabled-password ${SSH_USERNAME}
echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
