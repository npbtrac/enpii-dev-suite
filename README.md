# Nginx, PHP-FPM, ElasticSearch, Redis for development - Enpii Team

Docker running Nginx, PHP-FPM, ElasticSearch, Redis (special thanks to https://github.com/nanoninja/docker-nginx-php-mysql.git)

## Overview

1. [Install prerequisites](#install-prerequisites)

    Before installing project make sure the following prerequisites have been met.

2. [Installation](#installation)

    How to install all tools included

3. [Problem solving](#problem)
    Incurring issues and how to solve
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
### Clone the project
  - Clone or download the project
  - Change directory to the directory to use
      ```sh
      cd <path/to/project-directory>
      ./scripts/init.sh
      ```
      `chmod +x /scripts/init.sh` if you can't execute it
      For Mac use, it's better to create it inside your home, e.g `<path/to/project-directory>` = `~/workspace/enpii-dev-suite/`

### Create root directory for your website
  - Create folder www at the same level with `enpii-dev-suite` directory.
  - Create folder public_html inside www: `~/workspace/www/public_html` (This will be your local root directory)
  - Create info.php file inside public_html containing `<?php echo phpinfo();`

### Config docker-compose.yml
  - Repair params on `docker-compose.yml` of `etc/*.conf` or `etc/*.ini` files (those with the reminder comments) to match your local
  - Note: Refer to (step 2)[#create-root-directory-for-your-website] to check the path on your local machine as compared to inside the container.
    **For example:** For nginx container, the /var/www/html (inside the container) is equivalent to ../www (on your local machine created in step 2)
    
    ~~~~
    nginx:
        image: nginx:alpine
        container_name: enpii_dev_suite_nginx_main
        networks:
            - enpii_dev_suite
        volumes:
            - "./etc/nginx:/etc/nginx/conf.d"
            - "./etc/ssl:/etc/ssl"
            - "../www:/var/www/html" # Remember to replace `../www` with your actual www folder
            - "./log/nginx:/var/log/nginx"
    ~~~~   
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

### Create nginx conf file

### Assign domain to localhost IP

### Add SSL certificate

___
## Problem
1.  Version in "./docker-compose.yml" is unsupported
    
    Update your docker engine to version 17.12.0+ for using docker compose file version 3.5+. (If you use versions before 3.5, you will have error *Additional properties are not allowed* )
2.  Nginx is running but not pointing to correct root directory 

    You may encounter 404, 504 or your browser showing wrong contents when you direct to the domain name. There are two steps to check this error:
    
    - Open the error log file (you created in the conf file of nginx) to check the error notification
    - Check if you alias the directories correctly by reviewing your local directories and container’s directories. If the alias is set correctly, the files you put in your root folder locally should automatically appear in the root folder of the container.
    
    **For example**: You’ve created the file info.php (in [step 3](#config-docker-compose.yml)) inside `~/workspace/www/public_html`, and in the docker-compose.yml, you created an alias from local root to `/var/www/html` inside the container. Hence, the info.php should appear in the `/var/www/html/public_html` of the container
    Use the following commands to look for the file
    ~~~~
    $ docker exec -it enpii_dev_suite_nginx_main sh
    cd /var/www/html/public_html
    ls
    info.php
    ~~~~
    
    If you cannot find the file, then either recheck the alias you created in the docker-compose.yml or stop all containers from enpii-dev-suite and start them again to see if the changes take place.
3.  Fixing docker-compose.yml
    
    If you need to modify the docker-compose.yml file after you have started the containers, remember to run `docker-compose down` to turn off for checking changes on your params, if there’s any problem and docker can not turn off all of its service, restart docker program on your machine and run it again.
___



___

## Help us

Any thought, feedback or (hopefully not!)