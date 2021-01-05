#container os
FROM alpine:3.12

#add repo
RUN echo "@community http://dl-2.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories

#packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache telegraf@community

#telegraf binaries and conf

#scripts
#COPY ./srcs/setup.sh /tmp/
#RUN chmod +x /tmp/*.sh

RUN mkdir /etc/telegraf/
COPY ./srcs/telegraf.conf /etc/telegraf/

	#telegraf config >> /etc/telegraf/telegraf.conf && \
	#cat /tmp/telegraf.conf >> /etc/telegraf/telegraf.conf

#run telegraf
ENTRYPOINT telegraf
#CMD [ "sh", "/tmp/setup.sh" ]
