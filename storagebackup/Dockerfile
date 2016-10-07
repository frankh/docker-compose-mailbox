FROM phusion/baseimage:0.9.15

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y mysql-client-5.6 git gzip

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail -d /var/vmail && \
    mkdir -p /var/vmail && \
    chown vmail:vmail /var/vmail

ADD vmail.gitignore /tmp/vmail.gitignore
ADD mysql_backup.sh /etc/cron.daily/mysql_backup
ADD vmail_backup.sh /etc/cron.daily/vmail_backup

RUN chmod +x /etc/cron.daily/mysql_backup && \
    chmod +x /etc/cron.daily/vmail_backup

ADD setup_and_init.sh /tmp/setup_and_init.sh
CMD ["/tmp/setup_and_init.sh"]