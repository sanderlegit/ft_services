#!/bin/bash

# ---------- Colors ---------- #
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
MAGENTA=$'\e[1;35m'
CYAN=$'\e[1;36m'
END=$'\e[0m'

# ---------- Modular function for starting apps ---------- #
# $1 = name, $2 = docker-location, $3 = yaml-location
start_app () {
	printf "$1: "
	if [ "$4" == "--debug" ]
	then
		docker build -t $1 $2 && kubectl apply -f $3
	else
		docker build -t $1 $2 > /dev/null 2>>errlog.txt && kubectl apply -f $3 > /dev/null 2>>errlog.txt
	fi
    RET=$?
	if [ $RET -eq 1 ]
	then
		echo "[${RED}NO${END}]"
	else
		echo "[${GREEN}OK${END}]"
	fi
}

# ---------- Setting debug ---------- #
DEBUG=$""
if [ $# -eq 1 ]
then
    DEBUG="--debug"
fi

# ---------- Cleanup ---------- #
#rm -rf ~/.minikube
#mkdir -p ~/goinfre/.minikube
#ln -s ~/goinfre/.minikube ~/.minikube

:> errlog.txt

# ---------- Cluster start ---------- #
minikube start --driver=docker \
				--cpus=6 --memory=3900 --disk-size=10g \
				--addons=metallb \
				--extra-config=kubelet.authentication-token-webhook=true
				#--addons=default-storageclass \
				#--addons=dashboard \
				#--addons=storage-provisioner \
				#--addons=metrics-server \

# ---------- Build and deploy ---------- #
eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)
PROJECT_DIR="$(dirname $(realpath $0))"

kubectl apply -f $PROJECT_DIR/srcs/metallb/config.yaml
#kubectl apply -f $PROJECT_DIR/srcs/read_service_permissions.yaml
start_app "nginx" "$PROJECT_DIR/srcs/nginx" "$PROJECT_DIR/srcs/nginx/nginx.yaml" $DEBUG
#start_app "ftps" "$PROJECT_DIR/srcs/ftps" "$PROJECT_DIR/srcs/ftps/ftps.yaml" $DEBUG
#start_app "mysql" "$PROJECT_DIR/srcs/mysql" "$PROJECT_DIR/srcs/mysql/mysql.yaml" $DEBUG
#start_app "wordpress" "$PROJECT_DIR/srcs/wordpress" "$PROJECT_DIR/srcs/wordpress/wordpress.yaml" $DEBUG
#start_app "phpmyadmin" "$PROJECT_DIR/srcs/phpmyadmin" "$PROJECT_DIR/srcs/phpmyadmin/phpmyadmin.yaml" "$DEBUG"
#start_app "influxdb" "$PROJECT_DIR/srcs/influxdb" "$PROJECT_DIR/srcs/influxdb/influxdb.yaml" "$DEBUG"
#start_app "telegraf" "$PROJECT_DIR/srcs/telegraf" "$PROJECT_DIR/srcs/telegraf/telegraf.yaml" "$DEBUG"
#start_app "grafana" "$PROJECT_DIR/srcs/grafana" "$PROJECT_DIR/srcs/grafana/grafana.yaml" "$DEBUG"
