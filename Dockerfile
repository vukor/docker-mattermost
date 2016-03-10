## Version: 0.2
FROM centos
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Install deps
RUN yum update -y && \
    yum upgrade -y && \
    yum install wget -y && \
    yum clean all

## Create and work under non-privileged user
RUN useradd -d /home/m/ -s /sbin/nologin -U m
USER m
WORKDIR /home/m/

## Install mattermost
RUN wget https://github.com/mattermost/platform/releases/download/v2.0.0/mattermost.tar.gz && \
    tar -xzf mattermost.tar.gz -C . && \
    rm -f mattermost.tar.gz

## Add config
COPY ./mattermost-config.json /home/m/mattermost/config/config.json
User root
RUN chown m:m /home/m/mattermost/config/config.json && chmod 640 /home/m/mattermost/config/config.json
User m

WORKDIR /home/m/mattermost/bin/
CMD ["./platform"]

