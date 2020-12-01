docker build --no-cache -t boinc:arm64 .
docker tag boinc:arm64 izewfktvy533zjmn/boinc:arm64
docker push izewfktvy533zjmn/boinc:arm64
