quick test container for use with marathon and jenkins

jenkins job to build curl slave
```
touch Dockerfile
echo "FROM mrbobbytables/jenkins-build-base" >> Dockerfile
echo "RUN apt-get update && apt-get -y install curl && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*" >> Dockerfile
docker build -t registry.marathon.mesos:31111/curl-slave .
docker push registry.marathon.mesos:31111/curl-slave
```

jenkins job build and deploy nginx-test
```
git clone https://github.com/mrbobbytables/nginx-jenkins-marathon-test.git
echo ${BUILD_NUMBER} > nginx-jenkins-marathon-test/skel/build
docker build -t registry.marathon.mesos:31111/nginx-jm nginx-jenkins-marathon-test/
docker tag registry.marathon.mesos:31111/nginx-jm registry.marathon.mesos:31111/nginx-jm:${BUILD_NUMBER}
docker push registry.marathon.mesos:31111/nginx-jm
sed -i -e "s|registry.marathon.mesos:31111/nginx-jm:latest|registry.marathon.mesos:31111/nginx-jm:$BUILD_NUMBER|g" \
    nginx-jenkins-marathon-test/nginx-jm.host.marathon.local.json
curl -X PUT -H "Accept: application/json" -H "Content-Type: application/json" \
http://192.168.111.12:8080/v2/apps/nginx-jm -d @nginx-jenkins-marathon-test/nginx-jm.host.marathon.local.json

```

