## Version: 0.1
FROM alpine
MAINTAINER Anton Bugreev <anton@bugreev.ru>

## Install deps
RUN apk update && \
    apk add go git

## Create and work under non-privileged user
RUN adduser -D -s /sbin/nologin mmail mmmail
USER mmail
WORKDIR /home/mmail/

## Install MatterMail
RUN git clone https://github.com/rodrigocorsi2/mattermail.git
RUN export GOPATH=/home/mmail/ && \
    go get github.com/jhillyerd/go.enmime && \
    go get github.com/mattermost/platform/model && \
    go get github.com/mxk/go-imap/imap && \
    go get github.com/paulrosania/go-charset/charset && \
    go get github.com/paulrosania/go-charset/data && \
    go get github.com/rodrigocorsi2/mattermail

WORKDIR /home/mmail/mattermail/
CMD ["./mattermail"]

