#container OS
FROM alpine:3.12

#installing packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
    apk add --no-cache vsftpd \
	jq \
	gettext \
	curl

#ftp folder
RUN	mkdir -p /var/ftp

#conf
COPY ./srcs/vsftpd.conf /tmp/vsftpd.conf

#ssl certs
COPY ./srcs/ftps.cert /etc/ssl/certs/ftps.cert
COPY ./srcs/ftps.key /etc/ssl/certs/ftps.key

#scripts
COPY ./srcs/*.sh /tmp/
RUN chmod +x /tmp/*

#20 ?, 21 ftps, 30000 pasv
EXPOSE 20 21 30000

CMD ["sh" , "-c", "sh /tmp/setup.sh"]
