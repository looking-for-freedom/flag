// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    environment {
        MVN = "./mvnw -B -V -Dversion=${params.COMMIT_SHA}"
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
