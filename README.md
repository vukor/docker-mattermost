docker-mattermost
===========

This is project source for build and use docker images with Mattermost and PostgreSQL (offical image), both latest version. Image with Mattermost based on official image CentOS 7.


How it's work
===========

* Install docker and docker-compose on your system

* Download project:

    `` git clone https://vukor@github.com/vukor/docker-mattermost.git ``

* Go to project directory

* Set db account in docker-compose.yml and mattermost-config.json:

    `` DBPASSWORD=dbpassword ./manage.sh init ``

* Create two volume data for mattermost and postgres containers:
    
    `` ./manage.sh create-volumes ``

* Build image mattermost:

    `` ./manage build ``

* Create and start containers:

    `` ./manage up ``

* Go to http://your-docker-host:8065/

* Clean all (BE CAREFULL - this is remove all your mattermost's data volumes and containers):

    `` ./manage clean ``


How manage databases
===========

* For backup database db run:

    `` DBPASSWORD=dbpassword ./manage.sh backup ``

    Your backups will be located in backup/ directory.

* For restore database db run:
    
    `` DBPASSWORD=dbpassword ./manage.sh restore ``


Useful links
============
  - http://www.mattermost.org
  - http://docs.mattermost.com/install/prod-rhel-7.html
  - http://docs.docker.com/compose/
  - https://hub.docker.com/_/postgres/


The MIT License (MIT)
===========
Copyright (c) 2016 Anton Bugreev <anton@bugreev.ru>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

