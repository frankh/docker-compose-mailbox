#!/bin/bash

# CONF SETUP
sed -i -e "s/%ROUNDCUBE_DOMAIN%/${ROUNDCUBE_DOMAIN}/g" /etc/nginx/sites-enabled/roundcube
sed -i -e "s#%RANDOM_DES_KEY%#`openssl rand -base64 16`#g" ${roundcube_install_path}/config/config.inc.php

# DB SETUP
MAX_TIMEOUTS=0

while [ $MAX_TIMEOUTS -lt 30 ]; do
  mysql -u root -ppassword -h mysql -e "" &> /dev/null
  if [ $? -eq 0 ]; then
    break
  else
    sleep 1
  fi
  let MAX_TIMEOUTS=MAX_TIMEOUTS+1
  if [ $MAX_TIMEOUTS -gt 29 ]; then
    echo "ERROR: Could never connect to database $MAX_TIMEOUTS"
  fi
done
mysql -u root -ppassword -h mysql roundcube -e "" &> /dev/null

if [ $? -eq 0 ]; then
  echo "Using existing DB"
else
  echo "Creating and initializing DB"
  mysql -u root -ppassword -h mysql < /tmp/roundcube/db_setup.sql &> /dev/null && \
  echo "Roundcube setup completed successfully"
fi