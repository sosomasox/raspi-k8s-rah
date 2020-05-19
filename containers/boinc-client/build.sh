#!/bin/bash

docker build -t raspi-k8s-rah-boinc-client:latest .
docker tag raspi-k8s-rah-boinc-client:latest izewfktvy533zjmn/raspi-k8s-rah-boinc-client:latest
docker push izewfktvy533zjmn/raspi-k8s-rah-boinc-client:latest

exit 0
