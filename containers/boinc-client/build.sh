#!/bin/bash

docker build --no-cache -t boinc-client:arm64 .
docker tag boinc-client:arm64 sosomasox/boinc-client:arm64
docker push sosomasox/boinc-client:arm64

exit 0
