::this is reduced script due to many issues with docker on windows 10, fall back to manual as last resort
::in this approach make sure both JDK and MAven are downloaded first
SET image_name=tenkins
SET loacal_port=9090
docker container stop %image_name%
docker build --no-cache -t %image_name% .
docker run -p %local_port%:8080 -v downloads:/var/jenkins_home/downloads -v jobs:/var/jenkins_home/jobs/ --rm --name %image_name% %image_name%:latest
