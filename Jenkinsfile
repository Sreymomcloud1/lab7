pipeline {
    agent any

    environment {
        DOCKER_USER = "143mom"
        IMAGE_NAME = "foodexpress-app"
        AWS_REGION = "us-east-1"
        DOCKER_CREDS = credentials('docker-hub-creds')
    }

    stages {

        stage('Docker Login') {
            steps {
                sh '''
                echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
                '''
            }
        }

        stage('Build Image') {
            steps {
                sh "docker build -t ${DOCKER_USER}/${IMAGE_NAME}:latest ."
            }
        }

        stage('Push Image') {
            steps {
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
                    sh '''
                    terraform apply -auto-approve \
                    -var="image_name=143mom/foodexpress-app:latest"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }

        failure {
            echo "❌ Pipeline failed — check logs"
        }

        always {
            sh "docker logout || true"
        }
    }
}
