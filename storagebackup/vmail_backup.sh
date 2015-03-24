#!/bin/sh
find /var/vmail/* -depth -empty -type d -exec touch {}/.keep \;
cd /var/vmail
git add . --all
git commit -m 'Backup commit'
git archive master | gzip > /backup/vmail_backup-$(date +"%Y-%m-%d_%H:%M").tar.gz