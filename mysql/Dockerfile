FROM mariadb

ENV MYSQL_ROOT_PASSWORD password

ADD min-memory.cnf /etc/mysql/conf.d/min-memory.cnf
ADD bind-all.cnf /etc/mysql/conf.d/bind-all.cnf
RUN sed -Ei 's/^(;bind-address)/#&/' /etc/mysql/my.cnf

CMD ["mysqld"]
