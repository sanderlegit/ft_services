#container OS
FROM alpine:3.12

#add repo
RUN echo "@community http://dl-2.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories

#packages
RUN apk update --no-cache && \
	apk upgrade --no-cache && \
	apk add --no-cache grafana@community


#configuring dashboards and sources
COPY ./srcs/datasources.yaml /usr/share/grafana/conf/provisioning/datasources/datasources.yaml
COPY ./srcs/dashboards.yaml /usr/share/grafana/conf/provisioning/dashboards/dashboards.yaml
RUN mkdir -p /var/lib/grafana/dashboards
COPY ./srcs/dashboards/* /var/lib/grafana/dashboards/

#scripts
COPY ./srcs/create_user.sh /create_user.sh
RUN chmod +x /create_user.sh

#workdir
WORKDIR /usr/share/grafana

#neccessary port for dashboard
EXPOSE 3000

#start server
ENTRYPOINT grafana-server
