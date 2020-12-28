#!/bin/sh
adduser --disabled-password ${SSH_USERNAME}
echo "${SSH_USERNAME}:${SSH_PASSWORD}" | chpasswd
chown -R www:www /run/nginx
chown www:www /run/nginx/nginx.pid
