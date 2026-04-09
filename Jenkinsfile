pipeline {
    agent any

    environment {
        IMAGE_NAME = "foodexpress-app"
    }

    stages {
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
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
                    -var "image_name=$IMAGE_NAME" \
                    -var "key_1=your-key-name"
                    '''
                }
            }
        }
    }
}
