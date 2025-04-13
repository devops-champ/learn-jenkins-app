pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:20-slim'
                    reuseNode true
                }
            }
            steps {
                sh'''
                npm ci
                npm run build
                '''
            }
        }
    }
}
