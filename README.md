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

    `` cd docker-mattermost/ && docker-compose build ``

* Create and start containers:

    `` docker-compose up -d ``

* Go to http://your-docker-host:8065/

* For clean all run:

    `` cd docker-mattermost/ && docker-compose down ``
    
    `` docker volume rm mattermost-files-data ``
    
    `` docker volume rm mattermost-db-data ``


How manage databases
===========

* For backup database db run:
    
    `` cd docker-mattermost/ && docker-compose run --rm postgres bash -c "PGPASSWORD=dbpassword pg_dump --host=postgres --user=dbuser db" |gzip > ./backup/mattermost-db.sql.gz ``

    Your backups will be located in backup/ directory.

* For restore database db run:
    
    `` cd docker-mattermost/ && docker-compose stop mattermost && docker-compose run --rm postgres bash -c "export PGPASSWORD=dbpassword && dropdb --host=postgres --user=dbuser db && createdb --host=postgres --user=dbuser db && zcat /backup/mattermost-db.sql.gz| psql --host=postgres --user=dbuser db" && docker-compose start mattermost ``


Useful links
============
  - http://www.mattermost.org
  - http://docs.mattermost.com/install/prod-rhel-7.html
  - http://docs.docker.com/compose/
  - https://hub.docker.com/_/postgres/

