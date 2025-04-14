pipeline {
    agent any


    environment {
        NETLIFY_SITE_ID = 'b66c1b0f-306f-47ac-9291-36910161357e'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
    }

    stages {
        // stage('Build') {
        //     agent {
        //         docker {
        //             image 'node:20-slim'
        //             reuseNode true
        //         }
        //     }
            
        //     environment {
        //         // Set a custom cache directory inside the container to avoid permission issues
        //         NPM_CONFIG_CACHE = '/tmp/.npm'
        //     }

        //     steps {
        //         sh'''
        //         npm ci
        //         npm run build
        //         '''
        //     }
        // }


        // stage('Test') {
        //     agent {
        //         docker {
        //             image 'node:20-slim'
        //             reuseNode true
        //         }
        //     }            
            
        //     environment {
        //         // Set a custom cache directory inside the container to avoid permission issues
        //         NPM_CONFIG_CACHE = '/tmp/.npm'
        //     }

        //     steps {
        //         sh'''
        //         test -f build/index.html
        //         npm test

        //         '''
        //     }
        // }


        // stage('E2E') {
        //     agent {
        //         docker {
        //             image 'mcr.microsoft.com/playwright:v1.39.0-jammy'
        //             reuseNode true
        //         }
        //     }            
            
        //     environment {
        //         // Set a custom cache directory inside the container to avoid permission issues
        //         NPM_CONFIG_CACHE = '/tmp/.npm'
        //     }

        //     steps {
        //         sh'''
        //         npm install serve
        //         node_modules/.bin/serve -s build &
        //         sleep 10
        //         npx playwright test --reporter=html

        //         '''
        //     }
        // }


        stage('Deploy') {
            agent {
                docker {
                    image 'node:20'
                    reuseNode true
                }
            }            
            
            environment {
                NPM_CONFIG_CACHE = '/tmp/.npm'
                NPM_CONFIG_PREFIX = '/tmp/.npm-global' 
                PATH = "/tmp/.npm-global/bin:${PATH}"              
            }

            steps {
                sh'''
                mkdir -p /tmp/.npm-global
                npm install -g netlify-cli --unsafe-perm --cache=$NPM_CONFIG_CACHE
                node_modules/.bin/netlify --version
                '''
            }
        }                          
    }

    // post {
    //     always {
    //         junit 'jest-results/junit.xml'
    //         publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
    //     }
    // }


}
