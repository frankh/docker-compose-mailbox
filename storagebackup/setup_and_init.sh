#!/bin/bash

cd /var/vmail

git config --global user.email "$MAIL_POSTMASTER"
git config --global user.name "auto backup"

git status &> /dev/null || (git init . && cp /tmp/vmail.gitignore /var/vmail/.gitignore && git add . && git commit -m 'Initial commit')
chown vmail:vmail /var/vmail/.gitignore

mysql_config_editor set --login-path=roundcube --host=mysql --user=roundcube --password=password
mysql_config_editor set --login-path=vimbadmin --host=mysql --user=vimbadmin --password=password

exec /sbin/my_init