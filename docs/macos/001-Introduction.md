# Nginx, PHP-FPM, MySql for development - Enpii Team

## Overview
This is a development suite for development with PHP. It can be easily deployed with 1 or 2 commands. It includes:
- Nginx (`nginx_main` for serving as a proxy server)
- PHP-FPM (`php72_fpm`, `php_latest_fpm` for executing PHP scripts via FastCGI of Nginx)
- MySQL (`mysql57`, `mysql80` database, we have 5.7 for the stable and 8.0 is latest one)
- PhpMyAdmin (`phpmyadmin` tool for managing database)

After installing these containers, you can easily set up a local webserver using Docker. 
The detail of installation can be found here: [Installation Docs](./002-Installation.md)