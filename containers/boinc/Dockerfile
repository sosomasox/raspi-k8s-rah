FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y boinc

WORKDIR /var/lib/boinc-client

CMD ["/usr/bin/boinc"]
