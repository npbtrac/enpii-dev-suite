# Nginx, PHP-FPM, MySql for development - Enpii Team

## Overview
This is a development suite for development with PHP. It can be easily deployed with 1 or 2 commands. It includes:
- Nginx (`nginx_main` for serving as a proxy server)
- PHP-FPM (`php72_fpm`, `php_latest_fpm` for executing PHP scripts via FastCGI of Nginx)
- MySQL (`mysql57`, `mysql80` database, we have 5.7 for the stable and 8.0 is latest one)
- PhpMyAdmin (`phpmyadmin` tool for managing database)



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


## Installation
- Clone or download the project
- Copy `.env.example` -> `.env`
- Change directory to the directory to use
```sh
cd <path/to/project-directory>
# Init the .env file, then you can repair value needed to be updated
./scripts/init-env-file.sh 

# Init dev suite, you can add first option for the namespace of dev suite to overwrite the one in .env file
./scripts/init-dev-suite.sh
```
`chmod +x /scripts/init-dev-suite.sh` if you can't execute it
For Mac user, it's better to create it inside your home, e.g `<path/to/project-directory>` = `~/workspace/enpii-dev-suite/`
- Repair params on `docker-compose.yml` of `etc/*.conf` or `etc/*.ini` files to match your local
- Run Docker Compose
```sh
docker-compose up -d
```
- Wait for several mins and you'll have:
  - Nginx (work as a webserver)
  - PHP-FPM (PHP execution server)
  - MySql
  - phpmyadmin (should connect to mysql via host host.docker.internal)
  - We include MySQL in docker containers but because we believe database is important and you may lose you db once docker failed. Using a database server on local machine is out proposal: use `host.docker.internal` (for mac), `10.0.2.2` (for docker machine) for the hostname to connect to your main machine.

___

For PHP composer
- Run the PHP composer container which your project folder on local machine bound to `/var/www/html` of composer container
```bash 
docker-compose run --rm -v /path/to/your/project/folder:/var/www/html php74_composer composer update
```
Similar thing if you want to use php72 (use php72_composer instead)

For WP CLI
```bash
docker-compose run --rm -v /path/to/your/project/folder:/var/www/html php74_wp wp --allow-root plugin list
```
Similar thing if you want to use php72 (use php72_wp instead)

___

## Help us

Any thought, feedback or (hopefully not!)