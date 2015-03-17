FROM ubuntu:14.04

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail -d /var/vmail && \
    mkdir -p /var/vmail && \
    chown vmail:vmail /var/vmail

VOLUME /var/vmail
CMD echo Data only container