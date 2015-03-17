#!/usr/bin/env bash
. /tmp/settings.env

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/postfix/main.cf
