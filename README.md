docker-mattermost
===========

This is project source for build and use docker images with Mattermost and PostgreSQL (offical image), both latest version. Image with Mattermost based on official image CentOS 7.


How it's work
===========

* Download project:

    `` git clone https://vukor@github.com/vukor/docker-mattermost.git ``





* Install docker and docker-compose on your system

* [ OPTIONAL ] Change the docker-compose.yml. For example, you can change MYSQL_ROOT_PASSWORD or change php version (default php 5.6).

* Create volume data:
    
    `` cd docker-web-stack/ ``
    
    `` docker volume create --name data ``

* Create and start containers:

    `` docker-compose up -d ``

* Create your first virtual host:

    `` ./bin/create.prj.py PRJNAME `` (then documentroot is ./htdocs/PRJNAME/)

	or

    `` ./bin/create.prj.py -v5 PRJNAME `` (then documentroot is ./htdocs/PRJNAME/www/)

    After that put web files to documentroot

* For stop, start, restart containers run:
    
    `` docker-compose stop [container]``
    
    `` docker-compose start [container]``
    
    `` docker-compose restart [container]``

* Add zones (if you need) to files in directory .dnsmasq/zones

* Add to /etc/resolv.conf in head:

    `` nameserver 127.0.0.2 ``

How manage databases
===========

1. For connect to mysql service run:
    
    `` make db-cmd ``

2. For backup all your databases run:
    
    `` make db-backup ``

    Your databases will be located in backup/ directory.

3. For restore all databases from backup/ directory to mysql service run:
    
    `` make db-restore ``

How update images
============
Run:

`` make upgrade ``

This command backup all your databases, upgrade docker images, run new updated containers and restore all your databases.

How manage docker images
===========

1. For build all images in project run:
    
    `` make build ``

2. For push all images in project run:
    
    `` make push ``

Share dirs
===========

``.nginx/etc, .mysql5x/etc, .php5x/etc - config files``

``htdocs - web files``

``logs - app logs``

``backup - mysql backups``

Useful links
============
  - http://www.mattermost.org
  - http://docs.mattermost.com/install/prod-rhel-7.html
  - http://docs.docker.com/compose/
  - https://hub.docker.com/_/postgres/

