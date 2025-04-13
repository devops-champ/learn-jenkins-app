pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:20.19.0-slim'
                    reuseNode true
                }
            }
            steps {
                sh'''
                npm cache clean --force
                npm ci
                npm run build
                '''
            }
        }
    }
}
