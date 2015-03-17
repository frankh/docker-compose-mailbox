#!/bin/sh
mysqldump -u root -ppassword -h mysql --all-databases > /backup/database_backup-$(date +"%Y-%m-%d_%H:%M").sql