#!/usr/bin/ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ./restore.rb [options]"

  opts.on("-vm", "--vmail-backup", "vmail backup file") do |vm|
    options[:vmail_backup] = vm
  end
  opts.on("-rc", "--roundcube-backup", "roundcube backup file") do |rc|
    options[:roundcube_backup] = rc
  end
  opts.on("-va", "--vimbadmin-backup", "vimbadmin backup file") do |va|
    options[:vimbadmin_backup] = va
  end

  opts.on("-h", "--help", "print this help message") do |vb|
    puts opts
    exit
  end

end.parse!

vmail_backup = options[:vmail_backup]
roundcube_backup = options[:roundcube_backup]
vimbadmin_backup = options[:vimbadmin_backup]

unless vmail_backup
  vmail_backups = Dir["data/backup/vmail_backup*.tar.gz"].sort.reverse
  if vmail_backups.length == 0
    STDERR.puts "No vmail backups found, provide .tar.gz backup manually with -vm"
    exit 1
  end
  puts "Select which vmail backup to use (or specify manually with --vmail-backup)"
  vmail_backups.first(5).each_with_index do |filename, i|
    puts "  #{i+1}: #{filename}"
  end
  choice = STDIN.gets.chomp.to_i
  if choice > vmail_backups.first(5).length || choice < 1
    puts "Invalid selection - not skipping vmail restore"
  end
  vmail_backup = vmail_backups[choice-1]
end
unless roundcube_backup
  roundcube_backups = Dir["data/backup/db_roundcube_backup*.sql"].sort.reverse
  if roundcube_backups.length == 0
    STDERR.puts "No roundcube backups found, provide .sql backup manually with -rc"
    exit 1
  end
  puts "Select which roundcube backup to use (or specify manually with --roundcube-backup)"
  roundcube_backups.first(5).each_with_index do |filename, i|
    puts "  #{i+1}: #{filename}"
  end
  choice = STDIN.gets.chomp.to_i
  if choice > roundcube_backups.first(5).length || choice < 1
    puts "Invalid selection - not skipping roundcube restore"
    roundcube_backups = {}
  end
  roundcube_backup = roundcube_backups[choice-1]
end
unless vimbadmin_backup
  vimbadmin_backups = Dir["data/backup/db_vimbadmin_backup*.sql"].sort.reverse
  if vimbadmin_backups.length == 0
    STDERR.puts "No vimbadmin backups found, provide .sql backup manually with -va"
    exit 1
  end
  puts "Select which vimbadmin backup to use (or specify manually with --vimbadmin-backup)"
  vimbadmin_backups.first(5).each_with_index do |filename, i|
    puts "  #{i+1}: #{filename}"
  end
  choice = STDIN.gets.chomp.to_i
  if choice > vimbadmin_backups.first(5).length || choice < 1
    puts "Invalid selection - not skipping vimbadmin restore"
    vimbadmin_backups = {}
  end
  vimbadmin_backup = vimbadmin_backups[choice-1]
end
puts "Using vmail backup \"#{vmail_backup}\""
puts "Using roundcube backup \"#{roundcube_backup}\""
puts "Using vimbadmin backup \"#{vimbadmin_backup}\""

storage_box = `docker-compose ps storagebackup | grep storagebackup | cut -d' ' -f1`.chomp
exit 1 unless storage_box
puts "Found storage box '#{storage_box}'"
print "\nReady to restore, continue? <y/N>"
exit 1 unless STDIN.gets.chomp.downcase == "y"

puts "(1/4) Restoring mail files..."
`docker exec -i #{storage_box} tar -xzv -C /var/vmail < #{vmail_backup}`
`docker exec -i #{storage_box} rm /var/vmail/\\*/\\*/\\*.cache`
`docker exec -i #{storage_box} rm /var/vmail/\\*/\\*/\\*.index`
puts "(2/4) Fixing permissions..."
`docker exec -i #{storage_box} chown -R vmail:vmail /var/vmail`
if roundcube_backup
  puts "(3/4) Restoring roundcube DB..."
  `docker exec -i #{storage_box} mysql -u roundcube -ppassword -h mysql roundcube < #{roundcube_backup} 2>/dev/null`
end
if vimbadmin_backup
  puts "(4/4) Restoring vimbadmin DB..."
  `docker exec -i #{storage_box} mysql -u vimbadmin -ppassword -h mysql vimbadmin < #{vimbadmin_backup} 2>/dev/null`
end
puts "Done!"

