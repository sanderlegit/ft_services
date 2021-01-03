#add user pass
adduser -D -h /var/ftp -s /bin/false $FTPS_USERNAME
echo "$FTPS_USERNAME:$FTPS_PASSWORD" | /usr/sbin/chpasswd
#get pasv addr
export PASV_ADDR=""
while [ -z "$PASV_ADDR" ]
do
	. /tmp/get_external_ip.sh PASV_ADDR ftps-svc
	sleep 1
done
echo "Found IP: $PASV_ADDR"
#configure vsftpd
#envsubst '${FTPS_USERNAME} ${FTPS_PASSWORD} ${PASV_ADDR}' < /tmp/vstfpd.conf > /etc/vsftpd/vsftpd.conf
envsubst '${PASV_ADDR}' < /tmp/vsftpd.conf > /etc/vsftpd/vsftpd.conf
#run vsftpd
vsftpd /etc/vsftpd/vsftpd.conf