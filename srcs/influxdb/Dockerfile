#container OS
FROM alpine:3.12

#packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache influxdb

#DB port
EXPOSE 8086

#run daemon
ENTRYPOINT influxd
