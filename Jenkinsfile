pipeline {
    agent any

    // add an environment variable that directs npm to use a writable directory:
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
                # npm uses a directory inside your project workspace instead of the default location.
                npm ci --cache .npm
                npm run build
                ls -la
                '''
            }
        }

        stage('Test') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }            

            steps {
                sh '''
                test -f /build/index.html
                npm test
                '''
            }
        }        
    }
}
