ARG NGINX_VERSION

FROM nginx:${NGINX_VERSION}-alpine

WORKDIR /var/www/html
CMD /bin/sh /scripts/init-nginx.sh

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log