// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    environment {
        MVN = "./mvnw -B -V"
    }

    stages {
        stage('Info') {
            steps {
                echo 'Runtime inforamtion...'
                sh 'groups'
                sh 'env | sort'
                sh 'ls -l /bin/docker /var/run/docker.sock'
                sh 'ls -al $HOME/.m2'
                sh 'mount'
            }
        }

        stage('Set version') {
            steps {
                echo 'Setting version...'
                sh "${env.MVN} versions:set -DnewVersion=${env.COMMIT_SHA} versions:commit"
            }
        }

        stage('Build, Test, and Package') {
            steps {
                echo 'Building, testing, and packaging...'
                sh "${env.MVN} clean package"
            }
        }

        stage('Docker push') {
            steps {
                echo 'Pushing...'
                sh "${env.MVN} dockerfile:push"
            }
        }
    }
}
