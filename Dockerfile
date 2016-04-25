## Version: 0.3
FROM centos
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Set version
ENV MATTERMOST_VERSION 2.2.0

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
RUN wget https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz && \
    tar -xzf mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz -C . && \
    rm -f mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz

## Add config
COPY ./mattermost-config.json /home/m/mattermost/config/config.json
User root
RUN chown m:m /home/m/mattermost/config/config.json && chmod 640 /home/m/mattermost/config/config.json
User m

## Test operations
COPY test.sh /test.sh

WORKDIR /home/m/mattermost/bin/
CMD ["./platform"]

