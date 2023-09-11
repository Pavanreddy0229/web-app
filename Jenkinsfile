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
        stage('Build') {
            steps {
                sh '''cd terraform-config && terraform init'''
                sh '''cd terraform-config && terraform plan'''
            }
        }
		// stage('Test') {
        //     steps {
		// 	    withEnv(["AWS_REGION=us-west-1"]) {
		// 			sh '''cd ansible/roles && ansible-playbook ami.yml'''
		// 		}
        //     }
        // }
        stage('Deploy to staging') {		
            steps {
                //sh '''cd terraform-config/environments/staging && terraform init'''
                //sh '''cd terraform-config/environments/staging && terraform plan'''
                sh '''cd terraform-config && terraform apply -auto-approve && terraform destroy -auto-approve'''
            }
        }
        //  stage('Deploy to production') {
        //     steps {
		// 	    withEnv(["AWS_REGION=us-west-2"]) {
		// 			sh '''cd ansible/roles && ansible-playbook ami.yml'''
		// 		}
        //         sh '''cd terraform-config/environments/prod && terraform init'''
        //         sh '''cd terraform-config/environments/prod && terraform plan'''
        //         sh '''cd terraform-config/environments/prod && terraform apply -auto-approve && terraform destroy -auto-approve'''
        //     }
        // } 
    }
}