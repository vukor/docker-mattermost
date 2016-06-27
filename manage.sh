#!/bin/bash

function BackupDB()
{
  if [[ -d backup ]]
  then
    ## Backup database
    docker-compose run --user="root" --rm postgres bash -c \
      'echo " -- Backup Mattermost database --" ; \
      BACKUP_DATE=$(date +%Y-%m-%d) && \
      cd /backup/ && \
      PGPASSWORD=$POSTGRES_PASSWORD pg_dump --host=postgres --user=$POSTGRES_USER db |gzip > $BACKUP_DATE.mattermost-db.sql.gz && \
      ln -sf $BACKUP_DATE.mattermost-db.sql.gz latest.mattermost-db.sql.gz && \
      ls /backup/$BACKUP_DATE.mattermost-db.sql.gz ; \
      echo " -- Backup Mattermost database successfully finished --"'
  else
    echo "Backup dir does not exist!"
  fi
}

function BackupFiles()
{
  if [[ -d backup ]]
  then
    ## Backup files and delete old backups
    docker-compose run --user="root" --rm mattermost bash -c \
      'echo " -- Backup Mattermost files --" ; \
      BACKUP_DATE=$(date +%Y-%m-%d) && \
      cd /home/m/mattermost/data/ && \
      [ -d /backup ] && tar -czf /backup/$BACKUP_DATE.mattermost-data.tar.gz * && \
      cd /backup && ln -sf $BACKUP_DATE.mattermost-data.tar.gz latest.mattermost-data.tar.gz && \
      ls /backup/$BACKUP_DATE.mattermost-data.tar.gz ; \
      echo "-- Backup Mattermost files successfully finished. --"'
  else
    echo "Backup dir does not exist!"
  fi
}

function RestoreDB()
{
  if [[ -f backup/latest.mattermost-db.sql.gz ]]
  then
    ## Stop Mattermost for correctly restore database
    docker-compose stop mattermost
    
    ## Restore database
    docker-compose run --user="root" --rm postgres bash -c \
      'echo "-- Restore Mattermost database --" ; \
      export PGPASSWORD=$POSTGRES_PASSWORD && \
      dropdb --host=postgres --user=$POSTGRES_USER db && \
      createdb --host=postgres --user=dbuser db && \
      zcat /backup/latest.mattermost-db.sql.gz | psql --host=postgres --user=dbuser db >/dev/null; \
      echo "-- Restore Mattermost database successfully finished. --"'

    ## Start Mattermost
    docker-compose start mattermost
  else
    echo "Latest Mattermost database backup does not exist!"
  fi
}

function RestoreFiles()
{
  if [[ -f backup/latest.mattermost-data.tar.gz ]]
  then
    ## Restore mattermost files
    docker-compose run --user="root" --rm mattermost bash -c \
      'echo "-- Restore Mattermost files --" ; \
      cd /home/m/mattermost/data/ && \
      tar -xzf /backup/latest.mattermost-data.tar.gz ; \
      echo "-- Restore Mattermost files successfully finished. --"'
  else
    echo "latest Mattermost files backup does not exist!"
  fi
}

case $1 in

  update )
    docker-compose pull --ignore-pull-failures && ./manage.sh build && ./manage.sh down && ./manage.sh up
    ;;

  build )
    docker-compose build --force-rm --pull
    ;;

  init )
    [ -z $DBPASSWORD ] && echo "Run: DBPASSWORD=dbpassword ./manage.sh init" && exit 1
    sed -i "s/dbpassword/$DBPASSWORD/" mattermost-config.json docker-compose.yml
    docker volume create --name mattermost-files-data
    docker volume create --name mattermost-db-data
    ;;
	
  test )
    docker-compose run --rm mattermost /test.sh
    if [ $? != 0 ]; then exit 1; fi
    ;;

  stop )
    docker-compose stop
    ;;

  start )
    docker-compose start
    ;;

  up )
    docker-compose up -d
    ;;

  down )
    docker-compose down
    ;;

  backup )
    BackupDB
    echo ''
    BackupFiles
    ;;

  restore )
    RestoreDB
    RestoreFiles
    ;;

  clean )
    docker-compose down
    docker volume rm mattermost-files-data
    docker volume rm mattermost-db-data
    ;;

  * ) echo "Use: build|create-volumes|init|test|stop|start|up|backup|restore|clean" && exit 1 ;;

esac

exit 0

