FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y postfix postfix-mysql dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-mysql dovecot-sieve dovecot-managesieved
RUN apt-get install -y mysql-client-core-5.6

ADD dovecot/dovecot.sh .
RUN mkdir /etc/service/dovecot && \
    mv dovecot.sh /etc/service/dovecot/run && \
    chmod +x /etc/service/dovecot/run


RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /var/vmail

ADD settings-copy.env /tmp/settings.env
ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh

RUN rm -rf /etc/dovecot/*

ADD postfix/config/ /etc/postfix/
ADD dovecot/config/ /etc/dovecot/

ADD dovecot/compiletime_setup.sh /tmp/dovecot/compiletime_setup.sh
ADD postfix/compiletime_setup.sh /tmp/postfix/compiletime_setup.sh
RUN bash /tmp/dovecot/compiletime_setup.sh
RUN bash /tmp/postfix/compiletime_setup.sh

CMD ["/tmp/setup_and_init.sh"]
