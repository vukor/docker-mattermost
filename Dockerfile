## Version: 0.1
FROM centos
MAINTAINER Anton Bugreev <anton@bugreev.ru>

RUN yum update -y && \
    yum upgrade -y && \
    yum install wget -y && \
    yum clean all

RUN useradd -d /home/m/ -s /sbin/nologin -U m

USER m
WORKDIR /home/m/

RUN wget https://github.com/mattermost/platform/releases/download/v2.0.0/mattermost.tar.gz && \
    tar -xzf mattermost.tar.gz -C . && \
    rm -f mattermost.tar.gz

COPY ./mattermost-config.json /home/m/mattermost/config/config.json

WORKDIR /home/m/mattermost/bin/
CMD ["./platform"]

