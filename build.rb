#!/usr/bin/ruby
SETTINGS={}

def read_setting(setting_name, variable_name, default=nil, required=true)
  default_string = default ? " (default=#{default})" : ""
  print "#{setting_name}?#{default_string}: "
  SETTINGS[variable_name] = gets.chomp
  if SETTINGS[variable_name] == "" && default
    SETTINGS[variable_name] = default
  end

  while SETTINGS[variable_name] == "" && required do
    print "#{setting_name}?#{default_string}: "
    SETTINGS[variable_name] = gets.chomp
  end
end

read_setting("Email address domain", "MAIL_DOMAIN")
read_setting("Mail server domain", "MAIL_MX_DOMAIN", "mail.#{SETTINGS["MAIL_DOMAIN"]}")
read_setting("DKIM selector", "MAIL_DKIM_SELECTOR", "mail")
read_setting("Postmaster", "MAIL_POSTMASTER", "postmaster@#{SETTINGS["MAIL_DOMAIN"]}")

read_setting("Vimbadmin domain", "VIMBADMIN_DOMAIN", "vimbadmin.#{SETTINGS["MAIL_DOMAIN"]}")
read_setting("Vimbadmin superuser", "VIMBADMIN_SUPERUSER", "admin@#{SETTINGS["MAIL_DOMAIN"]}")

read_setting("Vimbadmin superuser password", "VIMBADMIN_SUPERUSER_PASSWORD", "#{`openssl rand -base64 16`.chomp}")

SETTINGS["VIMBADMIN_REMEMBERME_SALT"] = "#{`openssl rand -base64 24`.chomp}"
SETTINGS["VIMBADMIN_PASSWORD_SALT"] = "#{`openssl rand -base64 24`.chomp}"

read_setting("Roundcube domain", "ROUNDCUBE_DOMAIN", "webmail.#{SETTINGS["MAIL_DOMAIN"]}")

puts "Writing settings to settings.env"
open("settings.env", "w").write SETTINGS.map{|k, v| "#{k}=#{v}"}.join("\n")
