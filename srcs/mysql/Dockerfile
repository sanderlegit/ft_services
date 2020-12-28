#container os
FROM alpine:3.12

#packages
RUN	apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache mysql \
	mysql-client \
	gettext


#config
COPY ./srcs/my.cnf /tmp/

#table specifications
COPY ./srcs/create_tables.sql /tmp/

#scripts and permissions
COPY ./srcs/*.sh /tmp/*.sh
RUN chmod +x /tmp/*.sh

VOLUME /var/lib/mysql

ENTRYPOINT ["/bin/sh", "/tmp/setup.sh"]
