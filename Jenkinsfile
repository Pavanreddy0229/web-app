pipeline {
    agent any
    triggers {
       // poll repo every minute for changes
       pollSCM('* * * * *')
    }
    stages {
        stage('Checkout Source') {
            steps {
                git branch: 'main',credentialsId: 'pfp_creds', url: 'https://github.com/Pavanreddy0229/web-app.git'
            }
        }
        stage('Test') {
            steps {
                sh '''who am i'''
            }
        }
        stage('Build') {
            steps {
                sh '''npm install node index.js'''
            }
        }
        stage('Terraform init') {
            steps {
                sh '''cd terraform-config && terraform init'''
            }
        }
        stage('Terraform plan') {
            steps {
                sh '''cd terraform-config && terraform plan'''
            }
        }
        
    }
}
