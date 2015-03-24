#!/bin/sh
mysqldump -u root -ppassword -h mysql roundcube > /backup/db_roundcube_backup-$(date +"%Y-%m-%d_%H:%M").sql
mysqldump -u root -ppassword -h mysql vimbadmin > /backup/db_vimbadmin_backup-$(date +"%Y-%m-%d_%H:%M").sql