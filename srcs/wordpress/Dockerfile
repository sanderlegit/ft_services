#container OS
FROM alpine:3.12

#installing packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
    apk add --no-cache \
		php7-common php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib \
		php7-curl php7-mbstring php7-json php7-session php7-phar php7-cli \
		php7-zip php7-iconv php7-xml php7-imap php7-cgi fcgi php7-pdo \
		php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt \
		php7-gettext php7-ldap php7-ctype php7-dom\
		wget \
		curl \
		jq \
		gettext \
		nginx\
		supervisor

#create user www and group 'www', create neccessary directories 
RUN adduser -D -g 'www' www && \
	mkdir /www && \
	mkdir -p /run/nginx && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www

#nginx conf
COPY srcs/nginx.conf /etc/nginx/nginx.conf

#supervisord conf
COPY ./srcs/supervisord.conf /etc/supervisord.conf

#wp config, installer, permissions
COPY ./srcs/wp-config.php /tmp/wp-config.php
COPY ./srcs/wp-cli.phar /tmp/wp-cli.phar

#scripts and permissions
COPY ./srcs/get_external_ip.sh /tmp/
COPY ./srcs/setup.sh /tmp/
COPY ./srcs/wpinstall.sh /tmp/
COPY ./srcs/liveness.sh /tmp/
RUN chmod +x /tmp/*.sh

#make sure that our ssh daemon keeps restarting
RUN sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf

#wp port
EXPOSE 5050

#Add SSH user and configuer supervisord
CMD ["sh", "-c", "sh /tmp/setup.sh; /usr/bin/supervisord -c /etc/supervisord.conf"]
