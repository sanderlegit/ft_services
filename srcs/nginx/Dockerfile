#container OS
FROM alpine:3.12

#installing packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache nginx \
	jq \
	curl \
	gettext \
	openssh \
	supervisor

#create user www and group 'www', create directory for html files 
RUN adduser -D -g 'www' www && \
	mkdir /www && \
	mkdir -p /var/run/nginx

#and give permissions to nginx
RUN chown -R www:www /www && \
	chown -R www:www /var/lib/nginx

#generate host keys
RUN ssh-keygen -A

#nginx conf
COPY srcs/default.conf /tmp/default.conf

#index page
COPY srcs/index.html /tmp/index.html

#SSL certs
COPY srcs/localhost.cert /etc/ssl/localhost.cert
COPY srcs/localhost.key /etc/ssl/localhost.key

#supervisor config
COPY srcs/supervisord.conf /etc/supervisord.conf

#scripts and permissions
COPY ./srcs/*.sh /tmp/
RUN chmod +x /tmp/*.sh

#Opening ports, 80 HTTP, 443 HTTPS, 22 SSH
EXPOSE 80 443 22

#Add SSH user and configuer supervisord
CMD ["sh", "-c", "sh /tmp/setup.sh ; /usr/bin/supervisord -c /etc/supervisord.conf"]
