#Container OS
FROM alpine:3.12


#Installing Packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache nginx \
	openssh \
	supervisor

#User www and group 'www'
#Create a directory for html files
RUN adduser -D -g 'www' www && \
	mkdir /www && \
	chown -R www:www /var/lib/nginx && \
	chown -R www:www /www && \
	mkdir -p /var/run/nginx


RUN ssh-keygen -A

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY srcs/index.html /www/index.html

#SSL Certs
COPY srcs/localhost.cert /etc/ssl/localhost.cert
COPY srcs/localhost.key /etc/ssl/localhost.key

#SSH config
#COPY srcs/supervisord.conf /etc/supervisord.conf

#Scripts
COPY ./srcs/*.sh /tmp/
RUN chmod +x /tmp/*.sh

#Opening ports, 80 HTTP, 443 HTTPS, 22 SSH
EXPOSE 80 443 22

#CMD ["sh", "-c", "/tmp/setup.sh ; /usr/bin/supervisord -c /etc/supervisord.conf"]
