#!/bin/bash

if ! [[ -f /etc/certs/mail.private ]]; then
  echo "Mail cert not found, autogenerating..."
  openssl req -new -x509 -nodes -out /etc/certs/mail.cert -keyout /etc/certs/mail.private -subj "/C=/ST=/L=/O=/OU=/CN=${MAIL_DOMAIN}"
  echo "Generated certificate"
fi

postfix start
exec /sbin/my_init
