// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    parameters {
        string(
            name: 'Version',
            defaultValue: sh(returnStdout: true, script: 'git rev-parse HEAD').trim(),
            description: 'Version to build and tag, default is the Git commit SHA'
        )
    }

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
                sh "${env.MVN} compile -Dversion=${params.Version}"
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh "${env.MVN} test -Dversion=${params.Version}"
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging...'
                sh "${env.MVN} package -Dversion=${params.Version}"
            }
        }
        stage('Publish') {
            steps {
                echo 'Publishing...'
                sh "${env.MVN} deploy -Dversion=${params.Version}"
            }
        }
    }
}
