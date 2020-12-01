docker build --no-cache -t boinc-client:arm64 .
docker tag boinc-client:arm64 izewfktvy533zjmn/boinc-client:arm64
docker push izewfktvy533zjmn/boinc-client:arm64
