pipeline {
    agent any

    environment {
        AWS_REGION = 'ap-south-2' 
        S3_BUCKET = 'sourav-codedeploy-bucket-2026'
        APPLICATION_NAME = 'sourav-Microservice-App'
        DEPLOYMENT_GROUP = 'Microservice-DG'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Zip Artifact') {
            steps {
                sh 'zip -r deployment-package.zip . -x "*.git*"'
            }
        }

        stage('Deploy to AWS CodeDeploy') {
            steps {
                // Universal syntax that bypasses shorthand plugin bugs
                step([
                    $class: 'AWSCodeDeployPublisher',
                    credentialsId: 'aws-credentials-id', 
                    region: "${AWS_REGION}",
                    applicationName: "${APPLICATION_NAME}",
                    deploymentGroupName: "${DEPLOYMENT_GROUP}",
                    deploymentConfigName: 'CodeDeployDefault.AllAtOnce',
                    s3bucket: "${S3_BUCKET}",
                    includes: 'deployment-package.zip',
                    s3prefix: '',
                    subfolder: '',
                    version: false,
                    waitForOperations: true,
                    deploymentGroupAppspec: false,
                    useAccessKey: true
                ])
            }
        }
    }
}
