// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    stages {
        String mvn = './mvnw -B -V -Ddocker.registry="$DOCKER_REGISTRY_DOCKER_REGISTRY_SERVICE_HOST:$DOCKER_REGISTRY_DOCKER_REGISTRY_SERVICE_PORT"'

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
                sh "${mvn} versions:set -DnewVersion=${env.COMMIT_SHA} versions:commit"
            }
        }

        stage('Build, Test, and Package') {
            steps {
                echo 'Building, testing, and packaging...'
                sh "${mvn} clean package"
            }
        }

        stage('Docker push') {
            steps {
                echo 'Pushing...'
                sh "${mvn} dockerfile:push"
            }
        }
    }
}
