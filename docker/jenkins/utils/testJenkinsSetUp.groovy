//use this to test successful jenkins set-up
pipeline {
    agent any
    tools {
        jdk 'jdk8'
        maven 'maven35'
    }
    stages {
        stage('test java installation') {
            steps {
                sh 'java -version'
                sh 'which java'
            }
        }
        stage('test maven installation') {
            steps {
                sh 'mvn -version'
                sh 'which mvn'
            }
        }
    }
}