## Version: 0.1
FROM alpine
MAINTAINER Anton Bugreev <anton@bugreev.ru>

RUN apk --update upgrade && \
    apk add wget ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/cache/apk/*

RUN adduser -S -s /sbin/nologin mattermost

USER mattermost
WORKDIR /home/mattermost/

RUN wget https://github.com/mattermost/platform/releases/download/v2.0.0/mattermost.tar.gz && \
    tar -xzf mattermost.tar.gz && \
    rm -rf mattermost.tar.gz

