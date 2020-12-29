#!/bin/sh
# dynamic links to services, clean
. /tmp/get_external_ips.sh WORDPRESS_SVC wordpress-svc
. /tmp/get_external_ips.sh PHPMYADMIN_SVC phpmyadmin-svc
. /tmp/get_external_ips.sh GRAFANA_SVC grafana-svc
envsubst '${WORDPRESS_SVC} ${PHPMYADMIN_SVC} ${GRAFANA_SVC}' < /tmp/index.html > /www/index.html
rm /tmp/index.html
# ssh user
adduser --disabled-password ${SSH_USERNAME}
echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
