pipeline {
    agent any

    environment {
        AWS_REGION = '<your-region>'
        AWS_ACCOUNT_ID = '<your-account-id>'
        ECR_REPO_FRONTEND = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/my-frontend"
        ECR_REPO_BACKEND = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/my-backend"
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Clone your repo (if using Git)
                git '<your-repo-url>'
            }
        }

        stage('Build Frontend Docker Image') {
            steps {
                script {
                    // Build the frontend image using Dockerfile in the root
                    sh 'docker build -t my-frontend -f Dockerfile.frontend .'
                }
            }
        }

        stage('Build Backend Docker Image') {
            steps {
                script {
                    // Build the backend image using Dockerfile in the root
                    sh 'docker build -t my-backend -f Dockerfile.backend .'
                }
            }
        }

        stage('Authenticate to ECR') {
            steps {
                script {
                    // Authenticate Docker to ECR
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO_FRONTEND}"
                }
            }
        }

        stage('Push Frontend Docker Image') {
            steps {
                script {
                    // Tag and push frontend image to ECR
                    sh "docker tag my-frontend:latest ${ECR_REPO_FRONTEND}:latest"
                    sh "docker push ${ECR_REPO_FRONTEND}:latest"
                }
            }
        }

        stage('Push Backend Docker Image') {
            steps {
                script {
                    // Tag and push backend image to ECR
                    sh "docker tag my-backend:latest ${ECR_REPO_BACKEND}:latest"
                    sh "docker push ${ECR_REPO_BACKEND}:latest"
                }
            }
        }
    }
}
