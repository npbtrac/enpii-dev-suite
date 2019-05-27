#!/bin/bash

CWD=$(pwd)

cp $CWD/docker-compose.yml.example $CWD/docker-compose.yml
cp $CWD/.env.example $CWD/.env

cp $CWD/etc/nginx/default.conf.example $CWD/etc/nginx/default.conf

cp $CWD/etc/php/php56.ini.example $CWD/etc/php/php56.ini
cp $CWD/etc/php/php56-fpm.conf.example $CWD/etc/php/php56-fpm.conf
cp $CWD/etc/php/php56-fpm.d/www.conf.example $CWD/etc/php/php56-fpm.d/www.conf

cp $CWD/etc/php/php.ini.example $CWD/etc/php/php.ini
cp $CWD/etc/php/php-fpm.conf.example $CWD/etc/php/php-fpm.conf
cp $CWD/etc/php/php-fpm.d/www.conf.example $CWD/etc/php/php-fpm.d/www.conf