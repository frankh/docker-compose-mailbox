. /tmp/settings.env

sed -i -e "s/%VIMBADMIN_DOMAIN%/${VIMBADMIN_DOMAIN}/g" /etc/nginx/sites-enabled/vimbadmin

sed -i -e "s/%VIMBADMIN_REMEMBERME_SALT%/${VIMBADMIN_REMEMBERME_SALT}/g" ${vimbadmin_install_path}/application/configs/application.ini
sed -i -e "s/%VIMBADMIN_PASSWORD_SALT%/${VIMBADMIN_PASSWORD_SALT}/g" ${vimbadmin_install_path}/application/configs/application.ini
