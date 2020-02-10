#!/usr/bin/env bash
#Warning: execute that in GIT BASH (usually you have it), did not test on cygwin but should also work
#START
#CONF
jenkins_container_name="tenkins" #test jenkins
jenkins_home="/var/jenkins_home/"
local_port=9090

#Required dependencies
maven_file=apache-maven-3.5.0-bin.tar.gz
maven_url=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.0/apache-maven-3.5.0-bin.tar.gz

jdk8_file=jdk-8u121-linux-x64.tar.gz
jdk8_url=https://files-cdn.liferay.com/mirrors/download.oracle.com/otn-pub/java/jdk/8u121-b13/jdk-8u121-linux-x64.tar.gz

#RUN

clear
current_path=$(pwd)
dockerfile="DockerfileWin10"

#stop first
echo "Stopping and Removing all containers for a clean start"
docker container stop $(docker container ls -aq) && docker container rm $(docker container ls -aq)

#DOWNLOAD TOOLS, NEED TO BE DONE ONCE ONLY
echo "Checking if maven $maven_file and jdk8 $jdk8_file archives are present"
source downloads/download_tools.sh $maven_file $maven_url $jdk8_file $jdk8_url
#source downloads/download_tools.sh $maven_file $maven_url $jdk8_file $jdk8_url remove_existing_binaries

cd $current_path
#build new image so we have reproducible builds (mind we use LTS  as base so it can change)
echo "Building image"
docker build -f "${dockerfile}" --no-cache -t "$jenkins_container_name"
#create volumes to persist data
docker volume create jenkins_downloads && docker volume create jenkins_jobs
docker container create --rm --name "$jenkins_container_name" "$jenkins_container_name":latest
docker run -p $local_port:8080 --name "$jenkins_container_name" --rm "$jenkins_container_name"
echo "Copy dependency binaries and bootstrap jobs to running container"
docker cp $(pwd)/downloads "$jenkins_container_name":"$jenkins_home" && docker cp $(pwd)/jobs "$jenkins_container_name":"$jenkins_home"
docker container restart "$jenkins_container_name"
#END

# -------------------------------------------------------------------------------------------------------------------
# Important: Execute in POWERSHELL because tty is not supported on windoóws and winpty can be missing
docker exec -it tenkins ls -l /var/jenkins_home/jobs
docker exec -it tenkins ls -l /var/jenkins_home/downloads
