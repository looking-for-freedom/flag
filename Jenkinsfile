// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

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

        stage('Build, Test, and Deploy') {
            steps {
                echo 'Building, testing, and deploying...'
                sh "./mvnw -B -V clean deploy -Dversion=${params.COMMIT_SHA}"
            }
        }
    }
}
