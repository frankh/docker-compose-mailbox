FROM phusion/baseimage:0.9.15

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y opendkim opendkim-tools

ADD opendkim.sh .
RUN mkdir /etc/service/opendkim && \
    mv opendkim.sh /etc/service/opendkim/run && \
    chmod +x /etc/service/opendkim/run

ADD runtime_setup.sh /tmp/runtime_setup.sh
ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh
RUN mkdir -p /etc/ssl/certs

ADD opendkim.conf /etc/opendkim.conf

CMD ["/tmp/setup_and_init.sh"]
