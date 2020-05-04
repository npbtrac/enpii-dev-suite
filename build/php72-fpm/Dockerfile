FROM npbtrac/php:7.2-fpm

# Mysql 5.7
RUN apt-get -y install mysql-client-5.7 php7.2-apc

# Cleaning
RUN apt-get autoremove -y && apt-get clean \
    && rm -rf /var/lib/apt/lists/*