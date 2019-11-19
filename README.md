# tenkins

This is Jenkins for tests image, build off latest LTS,  The image provides automation of jenkins installation from docker with handy plugins, maven and java. It contains all you need to run:

- my jenkins seed job (pipelines, dsl, locks, ...) https://github.com/gabrielstar/seed
- selenium with maven
- jmeter with maven, performance plugin, etc .. https://github.com/gabrielstar/wrotqa55

Usage:

1. In shell/cygwin/docker for windows navigate to directory where jenkins-up.sh is
2. Run ./jenkins-up.sh
3. Navigate to YOUR_IP:9090

Info:

This image is build of current Jenkins LTS so from time to time Dockerfile needs to be adjusted
Installation requires valid JAVA URL and MAVEN URL. Especially JAVA URL is prone to change and it can be necessary to update it from time to time.
