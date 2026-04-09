pipeline {
    agent any

   environment {
    // Put your new Docker ID here
    DOCKER_USER = "143mom" 
    IMAGE_NAME = "foodexpress-app"
    DOCKER_CREDS = credentials('docker-hub-creds')
}

    stages {
        stage('Build & Login Docker') {
            steps {
                // Build the image using your Docker Hub username
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                
                // Log in to Docker Hub so we can push the image
                sh "echo \$DOCKER_CREDS_PSW | docker login -u \$DOCKER_CREDS_USR --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // Upload the image to the cloud so the EC2 instance can find it
                sh "docker push ${DOCKER_USER}/${IMAGE_NAME}:latest"
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    // Simple apply because your main.tf already has the hardcoded values
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    
    post {
        always {
            // Clean up by logging out of Docker on the Jenkins server
            sh "docker logout"
        }
    }
}
