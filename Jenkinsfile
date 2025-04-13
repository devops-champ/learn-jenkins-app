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
                sudo -u node npm ci
                sudo -u node npm run build
                '''
            }
        }
    }
}
