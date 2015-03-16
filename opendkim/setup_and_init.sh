#!/bin/bash

if ! [[ -f /etc/certs/dkim.private ]]; then
  echo "DKIM private key not found in data/certs, autogenerating..."

  mkdir -p /tmp/certs
  opendkim-genkey --testmode --domain=$MAIL_DOMAIN --selector=$MAIL_DKIM_SELECTOR --directory=/tmp/certs
  mv /tmp/certs/$MAIL_DKIM_SELECTOR.private /etc/certs/dkim.private
  mv /tmp/certs/$MAIL_DKIM_SELECTOR.txt /etc/certs/dkim.txt

  echo "Generated keys and DNS settings"
fi

bash /tmp/runtime_setup.sh

exec /sbin/my_init
