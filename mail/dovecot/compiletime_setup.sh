#!/usr/bin/env bash
. /tmp/settings.env

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/postfix/main.cf
sed -i -e "s/%MAIL_MX_DOMAIN%/${MAIL_MX_DOMAIN}/g" /etc/postfix/main.cf
