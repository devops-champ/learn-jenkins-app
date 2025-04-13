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
            
            environment {
                // Set a custom cache directory inside the container to avoid permission issues
                NPM_CONFIG_CACHE = '/tmp/.npm'
            }

            steps {
                sh'''
                npm ci
                npm run build
                '''
            }
        }


        stage('Test') {
            agent {
                docker {
                    image 'node:20-slim'
                    reuseNode true
                }
            }
            
            environment {
                // Set a custom cache directory inside the container to avoid permission issues
                NPM_CONFIG_CACHE = '/tmp/.npm'
            }

            steps {
                sh'''
                test -f build/index.html

                '''
            }
        }        
    }

    post {
        always {
            cleanWs()
        }
    }
}
