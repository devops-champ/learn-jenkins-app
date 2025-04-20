pipeline {
    agent any


    environment {

        REACT_APP_VERSION = "1.0$BUILD_ID"
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_ECS_CLUSTER = 'learnjenkins'
        AWS_ECS_SERVICE = 'jenkins-app-service'
        AWS_ECS_TASK = 'LearnJenkinsApps-task-def'
    }

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

        stage('Build Docker image') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args "-u root -v /var/run/docker.sock:/var/run/docker.sock --entrypoint=''"
                }
            }

            steps {
                sh '''
                amazon-linux-extras install docker
                pwd
                ls -la
                docker build -t mujenkinsapp /var/lib/jenkins/workspace/nodejs/
                '''
            }
        }

        stage('Deploy to AWS') {
            agent {
                docker {
                    image 'amazon/aws-cli'
                    args "-u root --entrypoint=''"
                }
            }

            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                sh'''
                aws --version
                yum install jq -y
                LATEST_TD_REVISION=$(aws ecs register-task-definition --cli-input-json file://aws/task-definition-prod.json | jq '.taskDefinition.revision')
                echo $LATEST_TD_REVISION
                aws ecs update-service --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE --task-definition $AWS_ECS_TASK:$LATEST_TD_REVISION
                aws ecs wait services-stable --cluster $AWS_ECS_CLUSTER --service $AWS_ECS_SERVICE
                '''
                }

            }
        }        


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


        // stage('Deploy to AWS') {
        //     agent {
        //         docker {
        //             image 'node:20'
        //             reuseNode true
        //         }
        //     }            
            
        //     environment {
        //     NPM_CONFIG_CACHE = "${WORKSPACE}/.npm"
        //     NPM_CONFIG_PREFIX = "${WORKSPACE}/.npm-global"           
        //     }

        //     steps {
        //         sh'''
        //         # Install and run Netlify CLI via npx
        //             npm install netlify-cli --cache=$NPM_CONFIG_CACHE
        //             npx netlify --version  # Verify version
        //             npx netlify deploy --dir=build --site=$NETLIFY_SITE_ID --auth=$NETLIFY_AUTH_TOKEN --prod
        //         '''
        //     }
        // }                          
    }

    // post {
    //     always {
    //         junit 'jest-results/junit.xml'
    //         publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, icon: '', keepAll: false, reportDir: 'playwright-report', reportFiles: 'index.html', reportName: 'Playwright HTML Report', reportTitles: '', useWrapperFileDirectly: true])
    //     }
    // }


}
