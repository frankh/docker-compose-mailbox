FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y opendkim opendkim-tools

ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh

ADD opendkim.conf /etc/opendkim.conf

CMD ["/tmp/setup_and_init.sh"]
