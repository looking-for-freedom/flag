import groovy.json.JsonOutput

/**
 * Notify the Atomist services about the status of a build based from a
 * git repository.
 */
def notifyAtomist(String teamIds, String buildStatus, String buildPhase="FINALIZED") {
    if (!teamIds) {
        echo 'No Atomist team IDs, not sending build notification'
        return
    }
    def payload = JsonOutput.toJson(
        [
            name: env.JOB_NAME,
            duration: currentBuild.duration,
            build: [
                number: env.BUILD_NUMBER,
                phase: buildPhase,
                status: buildStatus,
                full_url: env.BUILD_URL,
                scm: [
                    url: env.GIT_URL,
                    branch: env.COMMIT_BRANCH,
                    commit env.COMMIT_SHA
                ]
            ]
        ]
    )
    teamIds.split(',').each { teamId ->
        String endpoint = "https://webhook.atomist.com/atomist/jenkins/teams/${teamid}"
        sh "curl --silent -X POST -H 'Content-Type: application/json' -d '${payload}' ${endpoint}"
    }
}

/**
 * Simple Jenkins pipeline for Maven builds
 */
pipeline {
    agent any

    environment {
        MVN = './mvnw -B -V'
    }

    stages {
        stage('Notify') {
            steps {
                echo 'Sending build start...'
                notifyAtomist(env.ATOMIST_TEAMS, 'STARTED', 'STARTED')
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
    }

    post {
        always {
            echo 'Post notification...'
            notifyAtomist(env.ATOMIST_TEAMS, currentBuild.currentResult)
        }
    }
}
