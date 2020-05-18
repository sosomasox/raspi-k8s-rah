#!/bin/bash

docker build -t raspi-k8s-rah:latest .
docker tag raspi-k8s-rah:latest izewfktvy533zjmn/raspi-k8s-rah:latest
docker push izewfktvy533zjmn/raspi-k8s-rah:latest

exit 0
