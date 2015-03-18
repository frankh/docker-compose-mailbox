#!/usr/bin/env bash
sed -i -e "s/%MAIL_MX_DOMAIN%/${MAIL_MX_DOMAIN}/g" /etc/dovecot/conf.d/15-lda.conf

# Make mail log to syslog
sed -i -e "s#/var/log/mail.log#/var/log/syslog#g" /etc/syslog-ng/syslog-ng.conf

# Copy hosts file to chroot jail so that postfix can resolve opendkim
cp /etc/hosts /var/spool/postfix/etc/hosts
cp /etc/services /var/spool/postfix/etc/services
cp /etc/resolv.conf /var/spool/postfix/etc/resolv.conf
