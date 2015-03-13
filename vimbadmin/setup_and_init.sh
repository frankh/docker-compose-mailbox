#!/bin/bash
sh vimbadmin.nginx.sh > /etc/nginx/sites-enabled/vimbadmin && rm vimbadmin.nginx.sh
bash db_init.sh && rm db_init.sh
exec /sbin/my_init