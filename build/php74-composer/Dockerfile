FROM php:7.4.1-cli-alpine3.10

# Credits
# https://github.com/daper/docker-alpine-php/

MAINTAINER "Trac Nguyen <npbtrac@yahoo.com>"

# Install needed packages
RUN printf "\n%s\n%s" "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk add autoconf automake make gcc g++ libtool pkgconfig libmcrypt-dev re2c libressl@edge libressl-dev@edge git zlib-dev xdg-utils libpng-dev freetype-dev libjpeg-turbo-dev openssh-client libxslt-dev ca-certificates gmp-dev \
    && update-ca-certificates


# Configure PHP extensions
RUN docker-php-ext-configure gd \
    && docker-php-ext-install -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) gd gmp mysqli opcache pdo_mysql sockets

# Install ampq
RUN apk add rabbitmq-c@testing rabbitmq-c-dev@testing \
    && pecl install amqp \
    && docker-php-ext-enable amqp

# Install mongodb
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb

# Install apcu
RUN pecl install apcu \
    && docker-php-ext-enable apcu

# Install imagemagick
RUN apk add imagemagick-dev \
    && printf "\n" | pecl install imagick \
    && docker-php-ext-enable imagick

# Install redis
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install composer
RUN curl -sS "https://getcomposer.org/installer" | php
RUN mv composer.phar /usr/local/bin/composer

# https://github.com/hirak/prestissimo
RUN composer global require hirak/prestissimo

# Prepare config files
WORKDIR /var/www/html

# Cleane cache
RUN rm -rf /var/cache/apk && mkdir -p /var/cache/apk