pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '231590249329'
        ECR_REPO_FRONTEND = "231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend"
        ECR_REPO_BACKEND = "231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/backend"
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

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the unified image using the combined Dockerfile
                    sh 'docker build -t my-app .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container and map the desired ports
                    // Adjust the port numbers based on your application
                    sh 'docker run -d -p 8080:4000 -p 5001:5000 my-app'
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

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag and push the built image to ECR
                    sh "docker tag my-app:latest 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/frontend:latest"
                    sh "docker push 231590249329.dkr.ecr.us-east-1.amazonaws.com/pavi/backend:latest"
                }
            }
        }
    }
}
