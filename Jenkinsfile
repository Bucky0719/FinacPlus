pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "bucky0838/finacplus:latest"
        KUBECONFIG_FILE = "kubeconfig.yaml"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Bucky0719/FinacPlus.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }
        stage('Push Docker Image') {
            steps {
                sh 'docker login -u bucky0838 -p dckr_pat_79C2h7PDN21tTnkWp-4-xSNlHIg'
                sh 'docker push $DOCKER_IMAGE'
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                writeFile file: "$KUBECONFIG_FILE", text: """
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJZVY2dFRrSGZRSXN3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TkRFeU1URXdOVEk1TlRkYUZ3MHpOREV5TURrd05UTTBOVGRhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURnYzJOSWU3OTNPa0E4OFlsT21OVFlPRkh3VEFRcWcxczBsNFR5WUVxb2VhUXBEL2hMbVpHTmdZMmgKT3B1MDVyTi82d3BFUGxhbkhhRnFtcTFrQ1J1R2tFOVlNNFc5aElnQWpSL0g5MVdVNERYb0RhM2hzWmpjaVFPUApMdGRLbisxUENZMWxoSHZDZ3FzeUVyVTlTbU9DZXlRaVp1N3BrWnpRYkpEM1VvcmNXSmdxeXYvZmpRYWlwTVBqClZmV2hFelkzMnQ2VDlHcDVBNERmYXBVMW0xK2VVakc0OUhPaVFod3RXZ1hEdEM3ZzdlYnRzZm1YT0h5bE8yYkoKMTFkdktOT3JObWYzUTNOaDRCc2VLQUNLZkUvSElESVdMSjNrdFdGYUlERUR4ODdPY00yUlFjYitXMHlRaHpaSAp2RWtoOEluVFZUakxKZXd0T3AwUXRTbXRBb0JKQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSdGgvR0xCNk5ZNzdpa2wyb2tOWWI3ZUREd2t6QVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQUxwM3RHbDBoUgo5YzF5RUpBVmZQcE9TSWE5dS82bm15QUdrZElsSkVtTTRVMzBwVU9QM1lWcGNxTEx6enJoUlNiaUt4UU04N1FTCnpERCtVaEluUkl2QXg2c3M3RzQwTndsQkF1eW04UGl2c0ZKc1RmNHkwd0Z6NGZVeG95L1E4SUlJSkgvak1Sc20KOHJUYkFtY0JDdFE5cXRLSUFPVnNnT2UvMG1qLzMySExvME5pQ09meC9hUllYeXY3VnB5UG5CdEtLT0JTa2lRSwpZQTgvb1M0WUUrRHZrYzlpWHpHYlFBTzJDTGI5anFmRW9iQnhCMWUxcmxyQ2tWZGZzUVh0REd6cWFPNEh0dE9BClpEbGgvd29mMGJ2dStlU09DT1hPL3RoZDFVSnFBNUJnSzM5cFVOVHJXWWE4REg5czcwS05lQldOZytib0ZNbVkKSHM2eGMzdmlFNys3Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
                server: https://ADAB8EDA10576EF0A90A4A4118D3B98E.gr7.ap-south-1.eks.amazonaws.com
                """
                withEnv(["KUBECONFIG=${WORKSPACE}/$KUBECONFIG_FILE"]) {
                    sh 'kubectl apply -f k8s/deployment.yaml'
                    sh 'kubectl apply -f k8s/service.yaml'
                }
            }
        }
    }
}
