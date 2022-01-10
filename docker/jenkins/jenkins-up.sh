#!/usr/bin/env bash
#This should work on Linux and Windows7+Gitbash/Cygiwn

#CONF
jenkins_container_name="tenkins" #test jenkins
local_port=9090

#Required dependencies
maven_file=apache-maven-3.5.0-bin.tar.gz
maven_url=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.0/apache-maven-3.5.0-bin.tar.gz

jdk8_file=jdk-8u121-linux-x64.tar.gz
jdk8_url=https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/8u121-b13/jdk-8u121-linux-x64.tar.gz

#RUN

clear
echo "Running on:" `docker-machine ip default` " and building image $jenkins_container_name"
echo "Checking if maven $maven_file and jdk8 $jdk8_file archives are present"
current_path=`pwd`

#stop first
echo "Stopping existing container if running"
docker container stop $jenkins_container_name > /dev/null 2>&1 || :
#DOWNLOAD TOOLS, NEED TO BE DONE ONCE ONLY

source downloads/download_tools.sh $maven_file $maven_url $jdk8_file $jdk8_url
#source downloads/download_tools.sh $maven_file $maven_url $jdk8_file $jdk8_url remove_existing_binaries

cd $current_path

#build new image so we have reproducible builds (mind we use LTS  as base so it can change)
echo "Building image"
docker build --no-cache -t "$jenkins_container_name" .
# run container so it is removed after stopping, from https://hub.docker.com/r/jenkins/jenkins, preserve jobs
echo "Running jenkins image on http://"`docker-machine ip default`":$local_port"
docker run -p $local_port:8080 -v `pwd`/downloads:/var/jenkins_home/downloads -v `pwd`/jobs:/var/jenkins_home/jobs/ --rm --name "$jenkins_container_name" "$jenkins_container_name":latest
#docker run -p 9090:8080 -v downloads:/var/jenkins_home/downloads  --rm --name tenkins tenkins:latest
#docker run -p $local_port:8080 -v `pwd`/downloads:/var/jenkins_home/downloads  --rm --name "$jenkins_container_name" "$jenkins_container_name":latest

#process stops here, now execute manually to test all gogg
docker exec -it tenkins ls -l /var/jenkins_home/