#!/bin/bash -e
echo "----------------------------------------"
echo " PHP Local development with Nginx setup "
echo "----------------------------------------"
echo ""

echo "Generate self-signed certs to msdev/etc/ssl ----"
docker run --rm -v $PWD/etc/ssl:/certs dpyro/alpine-self-signed
echo ""

CURRENT_DIR="$PWD"

DOCKER_COMPOSE_FILE=$CURRENT_DIR/docker-compose.yml
if ! [ -f "$DOCKER_COMPOSE_FILE" ]; then
    cp $DOCKER_COMPOSE_FILE.example $DOCKER_COMPOSE_FILE
fi

DEV_NAMESPACE=$(grep DEV_NAMESPACE .env | xargs)
IFS='=' read -ra DEV_NAMESPACE <<< "$DEV_NAMESPACE"
DEV_NAMESPACE=${DEV_NAMESPACE[1]}

sed -i bak -e "s/{{DEV_NAMESPACE}}/${DEV_NAMESPACE}/g" $CURRENT_DIR/docker-compose.yml
sed -i bak -e "s/{{DEV_NAMESPACE}}/${DEV_NAMESPACE}/g" $CURRENT_DIR/.env

rm $CURRENT_DIR/docker-compose.ymlbak

NGINX_CONF_FILE=$CURRENT_DIR/etc/nginx/default.conf
if ! [ -f "$NGINX_CONF_FILE" ]; then
	cp $NGINX_CONF_FILE.example $NGINX_CONF_FILE
fi

