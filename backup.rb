#!/usr/bin/ruby
storage_box = `docker-compose ps | grep _storagebackup_ | cut -d' ' -f1`.chomp
exit 1 unless storage_box

puts "Found storage box '#{storage_box}', creating backups in data/backups..."

`docker exec #{storage_box} /etc/cron.daily/mysql_backup`
`docker exec #{storage_box} /etc/cron.daily/vmail_backup`
