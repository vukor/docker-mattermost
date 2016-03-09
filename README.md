docker-mattermost
===========

This is project source for build and use docker images with Mattermost and PostgreSQL (offical image), both latest version. Image with Mattermost based on official image CentOS 7.


How it's work
===========

* Download project:

    `` git clone https://vukor@github.com/vukor/docker-mattermost.git ``

* Install docker and docker-compose on your system

* Set db account in docker-compose.yml and mattermost-config.json

* Create 2 volume data for mattermost and postgres containers:
    
    `` docker volume create --name mattermost-files-data ``
    
    `` docker volume create --name mattermost-db-data ``

* Build image mattermost:

    `` docker-compose build ``

* Create and start containers:

    `` docker-compose up -d ``

* Go to http://your-docker-host:8065/


Useful links
============
  - http://www.mattermost.org
  - http://docs.mattermost.com/install/prod-rhel-7.html
  - http://docs.docker.com/compose/
  - https://hub.docker.com/_/postgres/

