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
* [ElasticSearch](https://docker.elastic.co/elasticsearch/elasticsearch)
* [Redis](https://hub.docker.com/_/redis/)
* [Generate Certificate](https://hub.docker.com/r/jacoelho/generate-certificate/)

This project use the following ports :

| Server     | Port |
|------------|------|
| Nginx      |   80 |
| Nginx SSL  |  443 |


## Installation
- Clone or download the project
- Change directory to the directory to use
```sh
cd <path/to/project-directory>
./scripts/init.sh
```
`chmod +x /scripts/init.sh` if you can't execute it
For Mac use, it's better to create it inside your home, e.g `<path/to/project-directory>` = `~/workspace/enpii-dev-suite/`
- Repair params on `docker-compose.yml` of `etc/*.conf` or `etc/*.ini` files to match your local
- Run Docker Compose
```sh
docker-compose up -d
```
- Wait for several mins and you'll have:
  - Nginx (work as a webserver)
  - PHP-FPM (PHP execution server)
  - ElasticSearch
  - Redis
  - phpmyadmin (should connect to mysql via host host.docker.internal)
  - We include MySQL in docker containers but because we believe database is important and you may lose you db once docker failed. Using a database server on local machine is out proposal: use `host.docker.internal` for the hostname to connect

___



___

## Help us

Any thought, feedback or (hopefully not!).