#!/bin/sh

MATTERMOST_VERSION="2.2.0"

if platform -version | grep ${MATTERMOST_VERSION}
then
  echo "test passed"
  exit 0
fi

echo "test failed"
exit 1

