properties([
    parameters([
        string(
            defaultValue: 'dev',
            name: 'Environment' // Parameter to specify the environment (e.g., dev, staging, prod)
        ),
        choice(
            choices: ['plan', 'apply', 'destroy'], 
            name: 'Terraform_Action' // Parameter to specify the Terraform action to perform
        )])
])
pipeline {
    agent any
    stages {
        stage('Preparing') {
            steps {
                sh 'echo Preparing' // Print a preparation message to the console
            }
        }
        stage('Git Pulling') {
            steps {
                git branch: 'main', url: 'https://github.com/Bazith1/Three-Tier-Project.git' 
                // Clone the specified Git repository and checkout the main branch
            }
        }
        stage('Init') {
            steps {
                withAWS(credentials: 'aws-key', region: 'ap-south-1') {
                    sh 'terraform -chdir=EKS-Cluster-TF/ init' // Initialize the Terraform working directory
                }
            }
        }
        stage('Validate') {
            steps {
                withAWS(credentials: 'aws-key', region: 'ap-south-1') {
                    sh 'terraform -chdir=EKS-Cluster-TF/ validate' // Validate the Terraform configuration files
                }
            }
        }
        stage('Action') {
            steps {
                withAWS(credentials: 'aws-key', region: 'ap-south-1') {
                    script {    
                        if (params.Terraform_Action == 'plan') {
                            sh "terraform -chdir=EKS-Cluster-TF/ plan " 
                            // Run Terraform plan with the specified environment variable file
                        } else if (params.Terraform_Action == 'apply') {
                            sh "terraform -chdir=EKS-Cluster-TF/ apply  -auto-approve" 
                            // Run Terraform apply to create/update infrastructure, auto-approving the action
                        } else if (params.Terraform_Action == 'destroy') {
                            sh "terraform -chdir=EKS-Cluster-TF/ destroy -auto-approve" 
                            // Run Terraform destroy to remove infrastructure, auto-approving the action
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}" 
                            // Throw an error if an invalid action is specified
                        }
                    }
                }
            }
        }
    }
}
