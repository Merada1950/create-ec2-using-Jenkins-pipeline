pipeline {
    agent any  // Use any available agent

    environment {
        // Define AWS credentials and destroy flag
        AWS_CREDENTIALS_ID = '339712843218'
        
        // Set this to 'false' to avoid destroying resources
        DESTROY_RESOURCES = 'true'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                // Checkout code from the repository
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                script {
                    // Initialize Terraform
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    // Generate Terraform plan
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform plan -out=tfplan'
                    }
                }
            }
        }

        stage('Terraform Apply') {
            when {
                expression { env.DESTROY_RESOURCES == 'true' }  // Only apply if not destroying resources
            }
            steps {
                script {
                    // Apply the Terraform plan with auto-approval
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform apply --auto-approve tfplan'
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { env.DESTROY_RESOURCES == 'true' }  // Destroy resources if the flag is set to true
            }
            steps {
                script {
                    echo "Destroying all resources..."
                    withCredentials([aws(credentialsId: "${env.AWS_CREDENTIALS_ID}", region: 'us-west-1')]) {
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            script {
                // Cleanup workspace or other post-build actions
                echo 'Cleaning up workspace...'
                cleanWs()
            }
        }

        success {
            echo 'Pipeline succeeded!'
        }

        failure {
            echo 'Pipeline failed!'
        }
    }
}
