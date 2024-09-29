pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '231590249329'
        ECR_REPO_FRONTEND = "231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend"
        ECR_REPO_BACKEND = "231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend"
    }

    tools {
  dockerTool 'docker'
}

    stages {
       stage('Git Checkout') {
            steps {
                git branch: 'main', credentialsId: 'git', url: 'https://github.com/Pavithra-42/Images_ECR_using_Jenkins.git'
            }
        }

       stage('Build Frontend Docker Image') {
            steps {
                script {
                    // Build the frontend image using the Dockerfile in the 'front_end' directory
                    sh 'docker build -t my-frontend ./front_end'
                }
            }
        }

        stage('Build backend Docker Image') {
            steps {
                script {
                    // Build the frontend image using the Dockerfile in the 'front_end' directory
                    sh 'docker build -t my-backend ./backend'
                }
            }
        }

        stage('Authenticate to ECR') {
            steps {
                script {
                    // Authenticate Docker to ECR
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend"
                }
            }
        }

        stage('Push Frontend Docker Image') {
            steps {
                script {
                    // Tag and push frontend image to ECR
                    sh "docker tag my-frontend:latest 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend:latest"
                    sh "docker push 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend:latest"
                }
            }
        }

        stage('Push Backend Docker Image') {
            steps {
                script {
                    // Tag and push backend image to ECR
                    sh "docker tag my-backend:latest 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/backend:latest"
                    sh "docker push 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/backend:latest"
                }
            }
        }
    }
}
