#configure database user
envsubst '${DB_USER} ${DB_PASSWORD}' < /tmp/my.cnf > /etc/my.cnf
mysql_install_db --user=$DB_USER --ldata=/var/lib/mysql
cat /tmp/create_tables.sql >> /tmp/sql
echo "" >> /tmp/sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;" >> /tmp/sql
echo "SET PASSWORD FOR '$DB_USER'@'localhost'=PASSWORD('${DB_PASSWORD}') ;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'127.0.0.1' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;" >> /tmp/sql
echo "GRANT ALL ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;" >> /tmp/sql
echo "FLUSH PRIVILEGES;" >> /tmp/sql
rm /tmp/create_tables.sql
#startup db with config
/usr/bin/mysqld --console --init_file=/tmp/sql
