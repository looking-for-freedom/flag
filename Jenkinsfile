// simple Jenkins pipeline for Maven builds
pipeline {
    agent any

    stages {
        stage('Build, Test, and Deploy') {
            steps {
                echo 'Building, testing, and deploying...'
                sh "./mvnw -B -V clean deploy -Dversion=${params.COMMIT_SHA}"
            }
        }
    }
}
