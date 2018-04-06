// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    environment {
        MVN = './mvnw -B -V'
    }

    stages {
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
    }
}
