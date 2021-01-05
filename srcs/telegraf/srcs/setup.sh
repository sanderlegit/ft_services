#!/bin/bash
#cd /tmp
##unpack
#tar xf telegraf-1.17.0_linux_amd64.tar.gz
##move to path
#cd telegraf-1.17.0
#chmod +x ./usr/bin/*
#cp -vR ./* /

#dpkg -i telegraf_1.17.0-1_amd64.deb
mkdir /etc/telegraf/
cat /tmp/telegraf.conf >> /etc/telegraf/telegraf.conf
telegraf
