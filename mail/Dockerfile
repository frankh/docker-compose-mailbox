FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y postfix dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql dovecot-sieve dovecot-managesieved

ADD dovecot/dovecot.sh .
RUN mkdir /etc/service/dovecot && \
    mv dovecot.sh /etc/service/dovecot/run && \
    chmod +x /etc/service/dovecot/run

ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh

ADD postfix/config/* /etc/postfix/
ADD dovecot/config/* /etc/dovecot/

CMD ["/tmp/setup_and_init.sh"]
