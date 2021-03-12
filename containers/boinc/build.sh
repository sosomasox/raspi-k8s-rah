#!/bin/bash

docker build --no-cache -t boinc:arm64 .
docker tag boinc:arm64 sosomasox/boinc:arm64
docker push sosomasox/boinc:arm64

exit 0
