#!/usr/bin/env bash
sed -i -e "s/%MAIL_MX_DOMAIN%/${MAIL_MX_DOMAIN}/g" /etc/dovecot/conf.d/15-lda.conf
