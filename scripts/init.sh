#!/bin/bash -e
echo "----------------------------------------"
echo " PHP Local development with Nginx setup "
echo "----------------------------------------"
echo ""

echo "Generate self-signed certs to msdev/etc/ssl ----"
docker run --rm -v $PWD/etc/ssl:/certs dpyro/alpine-self-signed
echo ""

CURRENT_DIR="$PWD"

ENV_FILE=$CURRENT_DIR/.env
if ! [ -f "$ENV_FILE" ]; then
    cp $ENV_FILE.example $ENV_FILE
fi

DOCKER_COMPOSE_FILE=$CURRENT_DIR/docker-compose.yml
if ! [ -f "$DOCKER_COMPOSE_FILE" ]; then
    cp $DOCKER_COMPOSE_FILE.example $DOCKER_COMPOSE_FILE
fi

DEV_NAMESPACE=$(grep DEV_NAMESPACE .env | xargs)
IFS='=' read -ra DEV_NAMESPACE <<< "$DEV_NAMESPACE"
DEV_NAMESPACE=${DEV_NAMESPACE[1]}

sed -i bak -e "s/{{DEV_NAMESPACE}}/${DEV_NAMESPACE}/g" $CURRENT_DIR/docker-compose.yml
sed -i bak -e "s/{{DEV_NAMESPACE}}/${DEV_NAMESPACE}/g" $CURRENT_DIR/.env

rm $CURRENT_DIR/docker-compose.ymlbak $CURRENT_DIR/.envbak

NGINX_CONF_FILE=$CURRENT_DIR/etc/nginx/default.conf
if ! [ -f "$NGINX_CONF_FILE" ]; then
	cp $NGINX_CONF_FILE.example $NGINX_CONF_FILE
fi

PHP56_INI_FILE=$CURRENT_DIR/etc/php/php56.ini
if ! [ -f "$PHP56_INI_FILE" ]; then
	cp $PHP56_INI_FILE.example $PHP56_INI_FILE
fi

PHP56_FPM_CONF_FILE=$CURRENT_DIR/etc/php/php56-fpm.conf
if ! [ -f "$PHP56_FPM_CONF_FILE" ]; then
	cp $PHP56_FPM_CONF_FILE.example $PHP56_FPM_CONF_FILE
fi

PHP56_FPM_WWW_CONF_FILE=$CURRENT_DIR/etc/php/php56-fpm.d/www.conf
if ! [ -f "$PHP56_FPM_WWW_CONF_FILE" ]; then
	cp $PHP56_FPM_WWW_CONF_FILE.example $PHP56_FPM_WWW_CONF_FILE
fi

PHP_INI_FILE=$CURRENT_DIR/etc/php/php.ini
if ! [ -f "$PHP_INI_FILE" ]; then
	cp $PHP_INI_FILE.example $PHP_INI_FILE
fi

PHP_FPM_CONF_FILE=$CURRENT_DIR/etc/php/php-fpm.conf
if ! [ -f "$PHP_FPM_CONF_FILE" ]; then
	cp $PHP_FPM_CONF_FILE.example $PHP_FPM_CONF_FILE
fi

PHP_FPM_WWW_CONF_FILE=$CURRENT_DIR/etc/php/php-fpm.d/www.conf
if ! [ -f "$PHP_FPM_WWW_CONF_FILE" ]; then
	cp $PHP_FPM_WWW_CONF_FILE.example $PHP_FPM_WWW_CONF_FILE
fi

