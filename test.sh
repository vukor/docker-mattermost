#!/bin/sh

MATTERMOST_VERSION="2.2.0"

if ./platform -version 2>&1 | grep ${MATTERMOST_VERSION} >/dev/null
then
  echo "test passed"
  exit 0
fi

echo "test failed"
exit 1

