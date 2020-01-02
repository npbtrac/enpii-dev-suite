FROM php:7.2.25-cli-alpine

# Credits
# https://github.com/daper/docker-alpine-php/

MAINTAINER "Trac Nguyen <npbtrac@yahoo.com>"

# Install needed packages
RUN printf "\n%s\n%s" "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk --update upgrade \
    && apk add autoconf automake make gcc g++ libtool pkgconfig libmcrypt-dev re2c libressl@edge libressl-dev@edge git zlib-dev xdg-utils libpng-dev freetype-dev libjpeg-turbo-dev openssh-client libxslt-dev ca-certificates gmp-dev \
    && update-ca-certificates


# Configure PHP extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) gd gmp mysqli opcache pdo_mysql sockets

# Install ampq
RUN apk add rabbitmq-c@testing rabbitmq-c-dev@testing \
    && pecl install amqp \
    && docker-php-ext-enable amqp

# Install raphf
RUN pecl install raphf \
    && docker-php-ext-enable raphf

# Install memcached
RUN apk add cyrus-sasl-dev libmemcached-dev \
    && git clone "https://github.com/php-memcached-dev/php-memcached.git" \
    && cd php-memcached \
    && git checkout php7 \
    && phpize \
    && ./configure --disable-memcached-sasl \
    && make \
    && make install \
    && docker-php-ext-enable memcached

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

# Install ssh2
RUN apk add libssh2-dev@edge \
    && wget "https://github.com/Sean-Der/pecl-networking-ssh2/archive/php7.zip" \
    && unzip php7.zip \
    && cd pecl-networking-ssh2-php7 \
    && phpize \
    && ./configure \
    && make && make install \
    && docker-php-ext-enable ssh2

# Install redis
RUN pecl install redis \
    && docker-php-ext-enable redis

# Install xdebug
RUN git clone --depth 1 "https://github.com/xdebug/xdebug" \
 && cd xdebug \
 && phpize \
 && ./configure \
 && make \
 && make install \
 && docker-php-ext-enable xdebug

# Install wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

# Cleane cache
RUN rm -rf /var/cache/apk && mkdir -p /var/cache/apk