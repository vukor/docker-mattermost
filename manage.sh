#!/bin/bash

case $1 in

  build )
    docker-compose build ;;

  create-volumes )
    docker volume create --name mattermost-files-data
    docker volume create --name mattermost-db-data
    ;;
  
  init )
    [ -z $DBPASSWORD ] && echo "Run: DBPASSWORD=YOURPASSWORD ./manage.sh init" && exit 1
    echo "sed -i 's/dbpassword/$DBPASSWORD/' mattermost-config.json docker-compose.yml"
    ;;
	
  test )
    docker-compose run --rm mattermost /test.sh
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

  backup )
    [ -z $DBPASSWORD ] && echo "Run: DBPASSWORD=YOURPASSWORD ./manage.sh backup" && exit 1
    docker-compose run --rm postgres bash -c "PGPASSWORD=$DBPASSWORD pg_dump --host=postgres --user=dbuser db" |gzip > ./backup/mattermost-db.sql.gz
    ;;

  restore )
    [ -z $DBPASSWORD ] && echo "Run: DBPASSWORD=YOURPASSWORD ./manage.sh restore" && exit 1
    docker-compose run --rm postgres bash -c "export PGPASSWORD=$DBPASSWORD && dropdb --host=postgres --user=dbuser db && createdb --host=postgres --user=dbuser db && zcat /backup/mattermost-db.sql.gz| psql --host=postgres --user=dbuser db"
    ;;

  clean )
    docker-compose down
    docker volume rm mattermost-files-data
    docker volume rm mattermost-db-data
    ;;

  * ) echo "Use: build|create-volumes|init|test|stop|start|up|backup|restore|clean" && exit 1 ;;

esac

exit 0

