#!/usr/bin/with-contenv bashio

# Fetch config values
MYSQL_ROOT_PW="$(bashio::config 'root_password')"
MYSQL_PORT="$(bashio::config 'port')"

# Setup data directory
mkdir -p /data/mysql
chown -R mysql:mysql /data/mysql

# Initialize DB if first startup
if [ ! -d /data/mysql/mysql ]; then
  mysql_install_db --user=mysql --datadir=/data/mysql
fi

# Launch MySQL server
exec mysqld \
  --datadir=/data/mysql \
  --port="$MYSQL_PORT" \
  --bind-address=0.0.0.0 \
  --pid-file=/data/mysql/mysqld.pid \
  --socket=/data/mysql/mysqld.sock &
SQL_PID="$!"

# Secure root user
sleep 5
mysql -u root --skip-password --socket=/data/mysql/mysqld.sock <<-EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW';
FLUSH PRIVILEGES;
EOF

wait "$SQL_PID"
