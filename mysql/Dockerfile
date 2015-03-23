FROM mariadb

ENV MYSQL_ROOT_PASSWORD password

ADD min-memory.cnf /etc/mysql/conf.d/min-memory.cnf

# comment out bind-address
RUN sed -Ei 's/^(;bind-address)/#&/' /etc/mysql/my.cnf

CMD ["mysqld"]
