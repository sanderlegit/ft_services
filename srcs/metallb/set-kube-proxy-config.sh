#!/bin/bash

## see what changes would be made, returns nonzero returncode if different
#kubectl get configmap kube-proxy -n kube-system -o yaml | \
#sed -e "s/strictARP: false/strictARP: true/" | \
#kubectl diff -f - -n kube-system

#echo $?
#if [ $? -ne 0 ]
#then
	#echo "Setting strictARP"
	## actually apply the changes, returns nonzero returncode on errors only
	#kubectl get configmap kube-proxy -n kube-system -o yaml | \
	#sed -e "s/strictARP: false/strictARP: true/" | \
	#kubectl apply -f - -n kube-system
	#if [ $? -eq 1 ]
	#then
		#echo "Failed to set strictARP"
		#exit 1
	#fi
#else
	#echo "strictARP already set"
#fi


## see what changes would be made, returns nonzero returncode if different
#kubectl get configmap kube-proxy -n kube-system -o yaml | \
#sed -e "s/mode: false/mode: true/" | \
#kubectl diff -f - -n kube-system

#echo $?
#if [ $? -ne 0 ]
#then
	#echo "Setting mode"
	## actually apply the changes, returns nonzero returncode on errors only
	#kubectl get configmap kube-proxy -n kube-system -o yaml | \
	#sed -e "s/mode: \"\"/mode: \"ipvs\"/" | \
	#kubectl apply -f - -n kube-system
	#if [ $? -eq 1 ]
	#then
		#echo "Failed to set mode"
		#exit 1
	#fi
#else
	#echo "mode already set"
#fi

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/mode: \"\"/mode: \"ipvs\"/" | \
kubectl apply -f - -n kube-system
