pipeline {
    agent any

    // add an environment variable that directs npm to use a writable directory:
    environment {
    NPM_CONFIG_CACHE = "${WORKSPACE}/.npm"
    }

    stages {
        stage("Run unit test and end-to-end test") {
            parallel {
                stage('Test') {
                    agent {
                        docker {
                            image 'node:18-alpine'
                            reuseNode true
                        }
                    }            

                    steps {
                        sh '''
                        npm ci --cache .npm
                        test -f build/index.html
                        npm test --cache .npm
                        '''
            }
        }

                stage('End to End testing') {
                    agent {
                        docker {
                            image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
                            reuseNode true
                        }
                    }            

                    steps {
                        sh '''
                        npm install serve
                        node_modules/.bin/serve -s build &
                        sleep 10
                        npx playwright test --reporter=html
                        '''
                    }
                } 

            }
        }

         
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
                # npm uses a directory inside your project workspace instead of the default location.
                npm ci --cache .npm
                npm run build
                ls -la
                '''
            }
        }


        stage('Deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                npm install netlify-cli --save-dev --cache .npm
                node_modules/.bin/netlify --version
                '''
            }
        }        
               
    }


    post {
        always {
            // junit 'test-results/junit.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
         }
     }
}
