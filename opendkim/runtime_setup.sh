#!/bin/bash

sed -i -e "s/%MAIL_DOMAIN%/${MAIL_DOMAIN}/g" /etc/opendkim.conf
sed -i -e "s/%MAIL_DKIM_SELECTOR%/${MAIL_DKIM_SELECTOR}/g" /etc/opendkim.conf

# Have to copy cert to non-volume mounted folder or it causes permissions errors
cp /etc/certs/dkim.private /etc/ssl/certs/dkim.private