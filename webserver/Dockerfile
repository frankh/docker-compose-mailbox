FROM phusion/baseimage:0.9.15

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y php5 php5-cgi php5-mcrypt php5-memcache php5-json php5-mysql php-gettext libapache2-mod-php5 \
                       git subversion nginx-extras php5-fpm mysql-client-core-5.6

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN mkdir -p /var/www

RUN rm /etc/nginx/sites-enabled/default
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

ENV vimbadmin_install_path /var/www/vimbadmin
RUN git clone https://github.com/opensolutions/vimbadmin.git ${vimbadmin_install_path} && \
    cd ${vimbadmin_install_path} && \
    git checkout 3.0.15 && \
    composer install && \
    rm -rf ${vimbadmin_install_path}/.git

ENV roundcube_install_path /var/www/roundcube
RUN git clone https://github.com/roundcube/roundcubemail.git ${roundcube_install_path} && \
    echo -n | openssl s_client -connect git.kolab.org:443 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'| tee '/usr/local/share/ca-certificates/git_kolab_org.crt' && \
    update-ca-certificates && \
    cd ${roundcube_install_path} && \
    git checkout 1.1.6 && \
    mv ${roundcube_install_path}/composer.json-dist ${roundcube_install_path}/composer.json && \
    composer install --no-dev && \
    rm -rf ${roundcube_install_path}/.git

ADD setup_and_init.sh /tmp/setup_and_init.sh
RUN chmod +x /tmp/setup_and_init.sh

#BEGIN SETUP

RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /var/vmail

ADD vimbadmin/ /tmp/vimbadmin
ADD roundcube/ /tmp/roundcube

# TODO: try and fix roundcube PEAR redeclared bug - in the meantime this fixes it (bug spews an ugly warning)
RUN rm ${roundcube_install_path}/vendor/pear-pear.php.net/PEAR/PEAR.php

RUN mv ${vimbadmin_install_path}/public/.htaccess.dist ${vimbadmin_install_path}/public/.htaccess
RUN cp /tmp/vimbadmin/vimbadmin.nginx.conf /etc/nginx/sites-enabled/vimbadmin
RUN cp /tmp/roundcube/roundcube.nginx.conf /etc/nginx/sites-enabled/roundcube
RUN cp /tmp/roundcube/config.inc.php ${roundcube_install_path}/config/config.inc.php
RUN cp /tmp/roundcube/password.config.inc.php ${roundcube_install_path}/plugins/password/config.inc.php
RUN cp /tmp/vimbadmin/application.ini ${vimbadmin_install_path}/application/configs/application.ini

RUN chown -R www-data:www-data /var/www/
CMD ["/tmp/setup_and_init.sh"]
