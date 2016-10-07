FROM phusion/baseimage:0.9.15

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y postfix postfix-mysql dovecot-core \
                       dovecot-imapd dovecot-pop3d dovecot-lmtpd \
                       dovecot-mysql dovecot-sieve dovecot-managesieved \
                       mysql-client-core-5.6 spamc

ADD dovecot/dovecot.sh .
RUN mkdir /etc/service/dovecot && \
    mv dovecot.sh /etc/service/dovecot/run && \
    chmod +x /etc/service/dovecot/run

RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /var/vmail

RUN groupadd spamd && \
    useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd && \
    mkdir -p /var/log/spamassassin && \
    chown -R spamd:spamd /var/log/spamassassin

RUN mkdir -p /var/lib/dovecot/sieve/global
ADD dovecot/dovecot.sieve /var/lib/dovecot/sieve/dovecot.sieve
RUN sievec /var/lib/dovecot/sieve/dovecot.sieve

ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh

RUN rm -rf /etc/dovecot/*

ADD postfix/config/ /etc/postfix/
ADD dovecot/config/ /etc/dovecot/

ADD dovecot/runtime_setup.sh /tmp/dovecot/runtime_setup.sh
ADD postfix/runtime_setup.sh /tmp/postfix/runtime_setup.sh

CMD ["/tmp/setup_and_init.sh"]
