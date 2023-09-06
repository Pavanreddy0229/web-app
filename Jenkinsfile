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
                sh '''whoami'''
            }
        }
        stage('Build') {
            steps {
<<<<<<< HEAD
                sh '''npm install node index.js'''
=======
                sh '''cd ansible/roles && ansible-playbook ami.yml'''
>>>>>>> 6dd50fc (updated repo)
                sh '''cd terraform-config && terraform init'''
                sh '''cd terraform-config && terraform plan'''
            }
        }
         stage('Deploy to staging') {
            steps {
                sh '''whoami'''
            }
        }
         stage('Deploy to production') {
            steps {
                sh '''whoami'''
            }
        } 
    }
}