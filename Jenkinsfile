// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    environment {
        MVN = './mvnw -B -V'
    }

    stages {
        stage('Clean') {
            steps {
                echo 'Cleaning...'
                sh "${env.MVN} clean"
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                sh "${env.MVN} compile -Dversion=${params.COMMIT_SHA}"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh "${env.MVN} test -Dversion=${params.COMMIT_SHA}"
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging...'
                sh "${env.MVN} package -Dversion=${params.COMMIT_SHA}"
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing...'
                sh "${env.MVN} deploy -Dversion=${params.COMMIT_SHA}"
            }
        }
    }
}
