pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Bucky0719/FinacPlus.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t demo_reactjs_image .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh 'docker tag demo_reactjs_image bucky0838/finacplus:latest'
                    sh 'docker login -u bucky0838 -p dckr_pat_79C2h7PDN21tTnkWp-4-xSNlHIg'
                    sh 'docker push bucky0838/finacplus:latest'
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'kubectl apply -f /home/ubuntu/k8s/deployment.yaml'
                    sh 'kubectl apply -f /home/ubuntu/k8s/service.yaml'
                }
            }
        }
    }
}
