pipeline {
    agent any

    environment {
        IMAGE_NAME = "foodexpress-app"
    }

    stages {

        stage('Clone Code') {
            steps {
                git 'https://github.com/your-username/foodexpress-app.git'
            }
        }

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
                    -var "key_name=your-key-name"
                    '''
                }
            }
        }
    }
}
