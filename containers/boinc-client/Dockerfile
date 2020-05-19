FROM arm64v8/ubuntu:18.04

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y boinc-client=7.9.3+dfsg-5ubuntu2 && \
    apt-get clean -y && \ 
    apt-get autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENV ROSETTA_AT_HOME_ACCOUNT_KEY=

ADD scripts/entrypoint.sh /usr/bin/

CMD ["/usr/bin/entrypoint.sh"]
