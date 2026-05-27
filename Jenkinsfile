pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-1' 
        S3_BUCKET = 'sourav-codedeploy-bucket'
        APPLICATION_NAME = 'Microservice-App'
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
                // Triggers CodeDeploy using the AWS credentials configured inside Jenkins
                step([$class: 'AWSCodeDeployPublisher',
                    awsAccessKeyId: '', 
                    awsSecretKey: '', 
                    credentialsId: 'aws-credentials-id', 
                    deploymentConfigName: 'CodeDeployDefault.OneAtATime',
                    deploymentGroupName: "${DEPLOYMENT_GROUP}",
                    applicationName: "${APPLICATION_NAME}",
                    s3bucket: "${S3_BUCKET}",
                    s3prefix: '',
                    subfolder: '',
                    includes: 'deployment-package.zip',
                    region: "${AWS_REGION}",
                    version: true,
                    waitForOperations: true
                ])
            }
        }
    }
}
