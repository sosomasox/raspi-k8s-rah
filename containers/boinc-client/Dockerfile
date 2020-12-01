FROM ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y boinc-client

ENV ROSETTA_AT_HOME_ACCOUNT_KEY=

ADD scripts/entrypoint.sh /usr/bin/

CMD ["/usr/bin/entrypoint.sh"]
