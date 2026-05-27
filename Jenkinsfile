pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-2' 
        S3_BUCKET = 'sourav-codedeploy-bucket-2026' // Match your exact bucket name here
        APPLICATION_NAME = 'sourav-Microservice-App' // Matches your AWS application name exactly
        DEPLOYMENT_GROUP = 'Microservice-DG'
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls your latest code from the GitHub repository
                checkout scm
            }
        }

        stage('Zip Artifact') {
            steps {
                // Packages application files into a zip file for AWS CodeDeploy
                sh 'zip -r deployment-package.zip . -x "*.git*"'
            }
        }

        stage('Deploy to AWS CodeDeploy') {
            steps {
                // Native block to handle token routing properly
                awsCodeDeploy(
                    credentialsId: 'aws-credentials-id',
                    region: "${AWS_REGION}",
                    applicationName: "${APPLICATION_NAME}",
                    deploymentGroupName: "${DEPLOYMENT_GROUP}",
                    deploymentConfig: 'CodeDeployDefault.AllAtOnce',
                    s3Bucket: "${S3_BUCKET}",
                    includes: 'deployment-package.zip',
                    waitForOperations: true
                )
            }
        }
    }
}
