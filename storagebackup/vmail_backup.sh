#!/bin/sh
echo "Backing up vmail folders..."
find /var/vmail/* -depth -empty -type d -exec touch {}/.keep \;
cd /var/vmail
# Ensure git crashing doesn't break backups
rm -f /var/vmail/.git/index.lock
git add . --all &> /dev/null
git commit -m 'Backup commit' &> /dev/null
echo "Committed changes - archiving..."
git archive master | gzip > /backup/vmail_backup-$(date +"%Y-%m-%d_%H:%M").tar.gz
echo "Done"