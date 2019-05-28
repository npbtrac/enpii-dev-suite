# Nginx, PHP-FPM, ElasticSearch, Redis for development - Enpii Team

Docker running Nginx, PHP-FPM, ElasticSearch, Redis (special thanks to https://github.com/nanoninja/docker-nginx-php-mysql.git)

## Overview

1. [Install prerequisites](#install-prerequisites)

    Before installing project make sure the following prerequisites have been met.

2. [Installation](#installation)

    How to install all tools included


___

## Install prerequisites

For now, this project has been mainly created for Unix `(Linux/MacOS)`. Perhaps it could work on Windows.

All requisites should be available for your distribution. The most important are :

* [Git](https://git-scm.com/downloads)
* [Docker](https://docs.docker.com/engine/installation/)
* [Docker Compose](https://docs.docker.com/compose/install/)

Check if `docker-compose` is already installed by entering the following command : 

```sh
which docker-compose
```

Check Docker Compose compatibility :

* [Compose file version 3 reference](https://docs.docker.com/compose/compose-file/)


### Images to use

* [Nginx](https://hub.docker.com/_/nginx/)
* [PHP-FPM](https://hub.docker.com/r/nanoninja/php-fpm/)
* [ElasticSearch](https://hub.docker.com/_/elasticsearch)
* [Redis](https://hub.docker.com/_/redis/)
* [Generate Certificate](https://hub.docker.com/r/jacoelho/generate-certificate/)

This project use the following ports :

| Server     | Port |
|------------|------|
| Nginx      |   80 |
| Nginx SSL  |  443 |


## Installation
### Clone the project
### Create root directory for your website
### Config docker-compose.yml

### Create nginx conf file
- Create a file called `loi-local.dev-srv.net.conf` to put to `etc/nginx/sites-enabled` in clone directory with the following content:
```
server {
    listen 80;
    listen [::]:80;
    server_name loi-local.dev-srv.net;

    index index.php index.html;
    error_log  /var/log/nginx/loi-local-dev-srv-error.log;  
    access_log /var/log/nginx/loi-local-dev-srv-access.log;
    root /var/www/html/public_html;
    set $php_fpm_document_root /var/www/html/public_html;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass backend_php;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $php_fpm_document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}


server {
    server_name loi-local.dev-srv.net;

    listen 443 ssl;
    fastcgi_param HTTPS on;

    ssl_certificate /etc/ssl/server.pem;
    ssl_certificate_key /etc/ssl/server.key;
    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;

    index index.php index.html;
    error_log  /var/log/nginx/loi-local-dev-srv-error.log;
    access_log /var/log/nginx/loi-local-dev-srv-access.log;
    root /var/www/html/public_html;
    set $php_fpm_document_root /var/www/html/public_html;

    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass backend_php;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $php_fpm_document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}

include /etc/nginx/conf.d/sites-enabled/*.conf;

```
As we replaced the actual data folders in `docker-compose.yml` file, remember to put the right directory which is alias in docker:

`../www:/var/www/html` 

=> `../www`: is your actual directory of the root folder.
=> `:/var/www/html`: is the directory reflected by docker, and it will operate in this directory.

Then check and restart nginx with the following commands:
```sh
docker exec -it <nginx-containter-name> nginx -t 
docker exec -it <nginx-containter-name> nginx -s reload
```
to have that domain name working `http://loi-local.dev-srv.net` and `https://loi-local.dev-srv.net`.

### Assign domain to localhost IP
- Open /etc/hosts   
        Add `127.0.0.1 loi-local.dev-srv.net` at the bottom
- Save & exit, then test your domain on the browser, you should see the content of the phpinfo file displayed.

### Add SSL certificate
When we use the domain `https://loi-local.dev-srv.net`, an error will occur:

```sh 
Error: Connection is not private (err_cert_authority_invalid)
```

This means the browser can not find the valid authority to this connection and ask if we want to proceed or not which may harm your machine.

In this case, we will proceed it as we already set up the authority personally which means it will not be issued by the third party.

## Problem

## Help us

Any thought, feedback or (hopefully not!)