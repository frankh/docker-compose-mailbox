. /tmp/settings.env

cp /tmp/roundcube/config.inc.php ${roundcube_install_path}/config/config.inc.php

sed -i -e "s/%ROUNDCUBE_DOMAIN%/${ROUNDCUBE_DOMAIN}/g" /etc/nginx/sites-enabled/roundcube
