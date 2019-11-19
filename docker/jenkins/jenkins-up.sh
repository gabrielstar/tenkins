#!/usr/bin/env bash

#check ip where
jenkins_container_name="tenkins" #test jenkins
local_port=9090
echo "Running on:" `docker-machine ip default` " and building $jenkins_container_name"
# run container so it is removed after stopping, from https://hub.docker.com/r/jenkins/jenkins
docker container stop tenkins || :
https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/8u121-b13/
docker build -t tenkins .
docker run -p $local_port:8080 -v `pwd`/downloads:/var/jenkins_home/downloads -v `pwd`/jobs:/var/jenkins_home/jobs/ --rm --name tenkins tenkins:latest
#process stops here, now execute manually
docker exec -it tenkins ls -l /var/jenkins_home/downloads
