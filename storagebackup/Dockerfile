FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y mysql-client-5.6 git gzip

RUN groupadd -g 5000 vmail && \
    useradd -g vmail -u 5000 vmail -d /var/vmail && \
    mkdir -p /var/vmail && \
    chown vmail:vmail /var/vmail

ADD vmail.gitignore /tmp/vmail.gitignore
ADD mysql_backup.sh /etc/cron.hourly/mysql_backup.sh
ADD vmail_backup.sh /etc/cron.hourly/vmail_backup.sh

RUN chmod +x /etc/cron.hourly/mysql_backup.sh && \
    chmod +x /etc/cron.hourly/vmail_backup.sh

ADD setup_and_init.sh /tmp/setup_and_init.sh
CMD ["/tmp/setup_and_init.sh"]