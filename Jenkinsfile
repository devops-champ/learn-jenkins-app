pipeline {
    agent any

    environment {
    NPM_CONFIG_CACHE = "${WORKSPACE}/.npm"
    }

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                ls -la
                node --version
                npm --version
                npm ci --cache .npm
                npm run build
                ls -la
                '''
            }
        }
    }
}
