// hola script //

pipeline {
    agent any

    environment {
        IMAGE_NAME = "firewall-frontend"
        CONTAINER_NAME = "firewall-frontend"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:latest .'
            }
        }

        stage('Stop Old Container') {
            steps {
                sh '''
                docker stop $CONTAINER_NAME || true
                docker rm $CONTAINER_NAME || true
                '''
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker run -d \
                  --name $CONTAINER_NAME \
                  -p 8080:80 \
                  $IMAGE_NAME:latest
                '''
            }
        }
    }
}
