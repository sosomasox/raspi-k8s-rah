#!/bin/bash

docker build -t raspi-k8s-rah-boinc:latest .
docker tag raspi-k8s-rah-boinc:latest izewfktvy533zjmn/raspi-k8s-rah-boinc:latest
docker push izewfktvy533zjmn/raspi-k8s-rah-boinc:latest

exit 0
