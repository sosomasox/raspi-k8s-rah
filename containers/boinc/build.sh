docker build --no-cache -t boinc:arm64v8 .
docker tag boinc:arm64v8 izewfktvy533zjmn/boinc:arm64v8
docker push izewfktvy533zjmn/boinc:arm64v8
