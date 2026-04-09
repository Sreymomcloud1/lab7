pipeline {
    agent any

    environment {
        // 1. CHANGE THIS to your actual Docker Hub username
        DOCKER_USER = "your-docker-username" 
        IMAGE_NAME = "foodexpress-app"
        // 2. Ensure this Key Pair name exists in your AWS us-east-1 console
        AWS_KEY_NAME = "your-key-name" 
        // Reference for Jenkins Credentials ID
        DOCKER_CREDS = credentials('docker-hub-creds')
    }

    stages {
        stage('Build & Login Docker') {
            steps {
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
                // Logs into Docker Hub using the credentials set in Jenkins
                sh "echo \$DOCKER_CREDS_PSW | docker login -u \$DOCKER_CREDS_USR --password-stdin"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                // This makes the image available for the EC2 instance to download
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
                    // We pass the full Docker Hub image path to Terraform
                    sh """
                    terraform apply -auto-approve \
                    -var "image_name=${DOCKER_USER}/${IMAGE_NAME}:latest" \
                    -var "foodexpress-key=${AWS_KEY_NAME}"
                    """
                }
            }
        }
    }
    
    post {
        always {
            // Clean up: Logout of Docker Hub on the Jenkins server
            sh "docker logout"
        }
    }
}
