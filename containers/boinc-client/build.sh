docker build --no-cache -t boinc-client:arm64v8 .
docker tag boinc-client:arm64v8 izewfktvy533zjmn/boinc-client:arm64v8
docker push izewfktvy533zjmn/boinc-client:arm64v8
