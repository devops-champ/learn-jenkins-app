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
                    image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                    reuseNode true
                }
            }            
            
            environment {
                // Set a custom cache directory inside the container to avoid permission issues
                NPM_CONFIG_CACHE = '/tmp/.npm'
            }

            steps {
                sh'''
                npm install serve
                node_modules/.bin/serve -s build &
                sleep 10
                npx playwright test --reporter=html

                '''
            }
        }


        stage('Deploy') {
            agent {
                docker {
                    image 'node:20'
                    reuseNode true
                }
            }            
            
            environment {
                // Set a custom cache directory inside the container to avoid permission issues
                NPM_CONFIG_CACHE = '/tmp/.npm'
            }

            steps {
                sh'''
                npx netlify --version
                '''
            }
        }                          
    }

    post {
        always {
            junit 'jest-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
        }
    }


}
