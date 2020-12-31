#!/bin/bash

# ---------- Colors ---------- #
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
MAGENTA=$'\e[1;35m'
CYAN=$'\e[1;36m'
END=$'\e[0m'

# ---------- Functions ---------- #
print_ip() {
	echo -n "http://" ; kubectl get svc | grep "$1" | awk '{printf "%s",$4}' ; echo -n ":" ; kubectl get svc | grep "$1" | awk '{print $5}' | cut -d ':' -f 1
}

print_ip_page() {
	echo -n "http://" ; kubectl get svc | grep "$1" | awk '{printf "%s",$4}' ; echo -n ":" ; echo -n $(kubectl get svc | grep "$1" | awk '{printf "%s",$5}' | cut -d ':' -f 1 ) ; echo $2
}

# $1 = name, $2 = docker-location, $3 = yaml-location
start_app () {
	printf "$1: "
	if [ "$4" == "--debug" ]
	then
		docker build -t $1 $PROJECT_DIR$2 && kubectl apply -f $PROJECT_DIR$3
	else
		docker build -t $1 $PROJECT_DIR$2 > /dev/null 2>>errlog.txt && kubectl apply -f $PROJECT_DIR$3 > /dev/null 2>>errlog.txt
	fi
    RET=$?
	if [ $RET -eq 1 ]
	then
		echo "[${RED}NO${END}]"
	else
		echo "[${GREEN}OK${END}]"
	fi
}

# ---------- Debug ---------- #
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
				--addons=default-storageclass \
				--addons=dashboard \
				--addons=storage-provisioner \
				--addons=metrics-server \
				--extra-config=kubelet.authentication-token-webhook=true

# ---------- Install ---------- #
# metallb
#bash $PROJECT_DIR/srcs/metallb/set-kube-proxy-config.sh
#kubectl apply -f $PROJECT_DIR/srcs/metallb/namespace.yaml
#kubectl apply -f $PROJECT_DIR/srcs/metallb/metallb.yaml
#kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# ---------- Build and deploy ---------- #
eval $(minikube docker-env)
export MINIKUBE_IP=$(minikube ip)
PROJECT_DIR="$(dirname $(realpath $0))"

cat $PROJECT_DIR/srcs/metallb/config.yaml | sed -e "s=IPHERE=$(minikube ip)-$(minikube ip | sed -En 's=(([0-9]+\.){3})[0-9]+=\1255=p')=" | kubectl apply -f -
kubectl apply -f $PROJECT_DIR/srcs/read_service_permissions.yaml
#start_app "ftps" "/srcs/ftps" "/srcs/ftps/ftps.yaml" $DEBUG
start_app "mysql" "/srcs/mysql" "/srcs/mysql/mysql.yaml" $DEBUG
start_app "wordpress" "/srcs/wordpress" "/srcs/wordpress/wordpress.yaml" $DEBUG
start_app "phpmyadmin" "/srcs/phpmyadmin" "/srcs/phpmyadmin/phpmyadmin.yaml" "$DEBUG"
#start_app "influxdb" "/srcs/influxdb" "/srcs/influxdb/influxdb.yaml" "$DEBUG"
#start_app "telegraf" "/srcs/telegraf" "/srcs/telegraf/telegraf.yaml" "$DEBUG"
#start_app "grafana" "/srcs/grafana" "/srcs/grafana/grafana.yaml" "$DEBUG"
start_app "nginx" "/srcs/nginx" "/srcs/nginx/nginx.yaml" $DEBUG

echo ""
print_ip "nginx-svc"
print_ip_page "nginx-svc" '/wordpress'
print_ip_page "nginx-svc" '/phpmyadmin'
print_ip "wordpress-svc"
print_ip "phpmyadmin-svc"
#print_ip "grafana-svc"
