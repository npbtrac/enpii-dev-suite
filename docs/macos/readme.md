# Check for prerequisites
All requisites should be available for your distribution. The most important are:

* [Git] (https://git-scm.com/downloads)
* [Docker] (https://docs.docker.com/engine/installation/)
* [Docker Compose] (https://docs.docker.com/compose/install/)

# Installation
- Clone and download the project to your working directory:
```
$ cd <path-to-your-workspace> 
$ git clone https://github.com/npbtrac/enpii-dev-suite
```
- Go to the working directory:
```
$ cd <path-to-your-workspace>/enpii-dev-suite
```
The current working folder will be `<path-to-your-workspace>/enpii-dev-suite`. After all the prerequisites have been installed, run the following commands to start the installation of docker images.
  - This command will check if there’s .env file, if there isn’t, it will init an .env file. Then you can repair value needed to be updated:
```
sh scripts/init-env-file.sh
```
  - Init dev suite, you can add first option for the namespace of dev suite to overwrite the one in .env file:
```
sh scripts/init-dev-suite.sh
```
  - Then bring up and download all the containers by the following command:
```
docker-compose up -d --build
```
- Wait for several mins and you'll have:
  - Nginx (work as a webserver)
  - PHP-FPM (PHP execution server)
  - MySql
  - Phpmyadmin
- When it finishes downloading, we can check the list of all services by the command:
```
docker-compose ps
```

# Configure the nginx conf
- Firstly, create a file called `index.html` within folder `<path-to-your-workspace>/www` and put some content.
- Before launching the website, we have to modify the configuration for the default.conf file of nginx container, which is located in `/etc/nginx`. 
- Later on, if you want to add configuration for other sites, simply create another conf file for each site and put it into folder `/etc/nginx/sites-enabled`.
- As we replaced the actual data folders in docker-compose.yml file, remember to put the right directory which is alias in docker:
```
"../www:/var/www/html" 
```
`../www` : is your actual directory of the root folder.
`:/var/www/html` : this is the directory reflected by docker, and it will operate in this directory.

- So the `/var/www/html/` will be the path to the `index.html` file.

- Then check and restart nginx with the following commands: 
```
docker exec -it nginx_main nginx -t 
docker exec -it nginx_main nginx -s reload
```
- If it’s still not working, run:
```
docker-compose down
``` 
to turn off for checking changes on your params, if there’s any problem and docker can not turn off all of its service, restart docker program on your machine and run it again. After that, run:
```
docker-compose up -d 
```

- Check container if nginx is running by the command:
```
docker-compose ps nginx_main
```
- The information of the container will be shown with its state as __“UP”__.

- If its state is shown as __“EXIT”__, that means there is error that nginx could not be started and we should check the log to see the cause.
```
docker-compose logs nginx_main
```
- To see the logs, usually, errors come from configuration and you can change the configs in `etc/nginx/default.conf`  or `*.conf` in `etc/nginx/sites-enabled` (because we will include all *.conf in that folder to our nginx config).

# Assign your domain to localhost IP
- Open `/etc/hosts` then add your domain to localhost:
```
127.0.0.1 your-domain-name.example
```
- Save & exit
- Now test your domain on the browser, you should see the content of file `index.html` shown.

# Set up Mysql Database 
- Mysql57 is the database system used for the website. In the .env file, the database name, root password (of the root user of local machine), mysql user and password are set which we can use to log in the phpmyadmin.
- The exposing port of local machine is mapped to 3306 of mysql container and we can use the name of the container and its root password to log in the Phpmyadmin which has exposing port is 11901 (declared in `docker-compose.yml`).
- Now go to your browser and get to the Phpmyadmin page: `your-domain-name.example:11901`
- But since the mysql container as well as its database can be deleted once we stop and restart the docker, it's better to use the mysql from the local machine. In this case, the server named `host.docker.internal` is used to mapped to local database.
- After log in, we can create a database for the website and manage it easily.

# Troubleshooting
 ### 1. Nginx is running but not pointing to correct root directory
- You may encounter 404, 504 or your browser showing wrong contents when you direct to the domain name. There are two steps to check this error:
  - Open the error log file (you created in the nginx conf file) to check the error notification.
  - Check if you alias the directories correctly by reviewing your local directories and container’s directories. If the alias is set correctly, the files you put in your root folder locally should automatically appear in the root folder of the container. For example, you’ve put the WP data inside `~/workspace/www/`, and in the `docker-compose.yml`, you created an alias from local root to `/var/www/html` inside the container. Hence, the WP data should appear in the `/var/www/html` of the container.

- To go through the container by the following command:
```
$ docker exec -it nginx_main sh
cd /var/www/
ls 
```
If you cannot find the `index.html`, then either recheck the alias you created in the `docker-compose.yml` or stop all containers from `enpii-dev-suite` and start them again to see if the changes take place.

### 2. Port is allocated
Whenever you restart your machine, or bring up the docker, some default ports would be allocated which leads to some error of the progress of docker and the error is like `Port is already allocated` is showing up. Some default ports would be 80, 443... In this case, we can just simply restart the Docker.
If the error is still there after restarting , we could check which service is running on that port by the following command:
```
lsof -nP -i4TCP:$PORT | grep LISTEN      
```
Remember to replace $PORT with the allocated port.
By doing this, a list of the services using the port will be shown. And we can modify and remove the service based on that.
