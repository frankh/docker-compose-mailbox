FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y spamassassin

RUN useradd -g spamd -s /bin/false -d /var/log/spamassassin spamd && \
    mkdir -p /var/log/spamassassin && \
    chown -R spamd:spamd /var/log/spamassassin

ADD spamd.sh /tmp/spamd.sh
RUN mkdir /etc/service/spamd && \
    mv /tmp/spamd.sh /etc/service/spamd/run && \
    chmod +x /etc/service/spamd/run

CMD ["/sbin/my_init"]