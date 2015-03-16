#!/bin/bash
. /tmp/settings.env

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/opendkim.conf
sed -i -e "s/%MAIL_DKIM_SELECTOR%/${MAIL_DKIM_SELECTOR}/g" /etc/opendkim.conf
