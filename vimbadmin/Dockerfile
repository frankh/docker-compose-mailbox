FROM phusion/baseimage:latest

ENV DEBIAN_FRONTEND noninteractive

# vimbadmin dependencies
RUN apt-get update
RUN apt-get install -y php5 php5-cgi php5-mcrypt php5-memcache php5-json php5-mysql php-gettext libapache2-mod-php5 git subversion
RUN apt-get install -y nginx-extras php5-fpm


RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN mkdir -p /var/www
ENV install_path /var/www/vimbadmin

RUN git clone https://github.com/opensolutions/ViMbAdmin.git ${install_path}
RUN cd ${install_path} && composer install --dev
#TODO remove --dev

RUN apt-get install -y mysql-client-core-5.6

RUN rm /etc/nginx/sites-enabled/default
ADD vimbadmin/vimbadmin.nginx.sh .

ADD nginx/nginx.sh .
ADD nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir /etc/service/nginx && \
    mv nginx.sh /etc/service/nginx/run && \
    chmod +x /etc/service/nginx/run

ADD php-fpm/php-fpm.sh .
ADD php-fpm/php-fpm.ini /etc/php5/fpm/php-fpm.ini
ADD php-fpm/php.ini /etc/php5/fpm/php.ini
RUN mkdir /etc/service/php-fpm && \
    mv php-fpm.sh /etc/service/php-fpm/run && \
    chmod +x /etc/service/php-fpm/run

ADD setup_and_init.sh .
RUN chmod +x setup_and_init.sh

RUN chown -R www-data:www-data /var/www/

ADD vimbadmin/application.ini ${install_path}/application/configs/application.ini
ADD vimbadmin/db_init.sh .
ADD vimbadmin/db_setup.sql .
RUN mv ${install_path}/public/.htaccess.dist ${install_path}/public/.htaccess

CMD ["./setup_and_init.sh"]
EXPOSE 80
