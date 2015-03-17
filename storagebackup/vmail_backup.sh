#!/bin/sh
cd /var/vmail
git add .
git commit -m 'Backup commit'
git archive master | gzip > /backup/vmail_backup-$(date +"%Y-%m-%d_%H:%M").tar.gz