#!/usr/bin/env bash
. /tmp/settings.env

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/dovecot/conf.d/15-lda.conf
