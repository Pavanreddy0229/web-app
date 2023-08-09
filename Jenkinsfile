pipeline {
    agent any
    export AWS_ACCESS_KEY_ID="AKIAWOJLONZNWRQQNP6T"
    export AWS_SECRETE_ACCESS_KEY="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"
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
    /*    stage('Test') {
            steps {
                sh '''npm test'''
            }
        }*/
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
