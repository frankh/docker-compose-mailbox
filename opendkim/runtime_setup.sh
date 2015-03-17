#!/bin/bash

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/opendkim.conf
sed -i -e "s/%MAIL_DKIM_SELECTOR%/${MAIL_DKIM_SELECTOR}/g" /etc/opendkim.conf

# Make mail log to syslog
sed -i -e "s#/var/log/mail.log#/var/log/syslog#g" /etc/syslog-ng/syslog-ng.conf

# Have to copy cert to non-volume mounted folder or it causes permissions errors
cp /etc/certs/dkim.private /etc/ssl/certs/dkim.private