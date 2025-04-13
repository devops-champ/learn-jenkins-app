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
                npm test

                '''
            }
        }


        stage('E2E') {
            agent {
                docker {
                    image 'mcr.microsoft.com/playwright:v1.51.1-noble'
                    reuseNode true
                }
            }            
            
            environment {
                // Set a custom cache directory inside the container to avoid permission issues
                NPM_CONFIG_CACHE = '/tmp/.npm'
            }

            steps {
                sh'''
                npm install -g serve
                serve -s build
                npx playwright test

                '''
            }
        }                 
    }

    post {
        always {
            junit 'test-results/junit.xml'
        }
    }


}
