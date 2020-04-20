FROM arm64v8/ubuntu:18.04

RUN apt update && apt -y upgrade && apt clean all
RUN apt install -y boinc-client=7.9.3+dfsg-5ubuntu2 sudo tzdata 
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

COPY cc_config.xml /var/lib/boinc-client/

WORKDIR /var/lib/boinc

CMD ["sudo", "-u", "boinc", "/usr/bin/boinc"]
