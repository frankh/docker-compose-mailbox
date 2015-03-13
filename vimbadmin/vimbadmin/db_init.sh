#!/bin/bash
MAX_TIMEOUTS=0

while [ $MAX_TIMEOUTS -lt 10 ]; do
  mysql -u root -ppassword -h mysql -e "" &> /dev/null
  if [ $? -eq 0 ]; then
    break
  else
    sleep 1
  fi
  let MAX_TIMEOUTS=MAX_TIMEOUTS+1
  if [ $MAX_TIMEOUTS -gt 9 ]; then
    echo "ERROR: Could never connect to database $MAX_TIMEOUTS"
  fi
done
mysql -u root -ppassword -h mysql vimbadmin -e "" &> /dev/null

if [ $? -eq 0 ]; then
  echo "Using existing DB"
else
  echo "Creating DB and Superuser"
  mysql -u root -ppassword -h mysql < db_setup.sql &> /dev/null && \
  rm db_setup.sql

  HASH_PASS=`php -r "echo password_hash('$VIMBADMIN_SUPERUSER_PASSWORD', PASSWORD_DEFAULT);"`
  cd $vimbadmin_install_path && ./bin/doctrine2-cli.php orm:schema-tool:create && \
  mysql -u vimbadmin -ppassword -h mysql vimbadmin -e \
    "INSERT INTO admin (username, password, super, active, created, modified) VALUES ('$VIMBADMIN_SUPERUSER', '$HASH_PASS', 1, 1, NOW(), NOW())" && \
  echo "Setup completed successfully"
fi