#container os
FROM alpine:3.12

#add repo
RUN echo "@community http://dl-2.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories

#packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache telegraf@community

RUN mkdir /etc/telegraf/
COPY ./srcs/telegraf.conf /etc/telegraf/

#run telegraf
ENTRYPOINT telegraf
