#!/usr/bin/env bash
. /tmp/settings.conf

sed -i -e "s/%MAIL_POSTMASTER%/${MAIL_POSTMASTER}/g" /etc/dovecot/conf.d/15-lda.conf
sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/dovecot/conf.d/15-lda.conf
sed -i -e "s/%MAIL_POSTMASTER%/${MAIL_POSTMASTER}/g" /etc/dovecot/conf.d/20-lmtp.conf
