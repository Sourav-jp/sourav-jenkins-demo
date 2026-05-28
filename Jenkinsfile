pipeline {

    agent any

    stages {

        stage('Prepare Scripts') {
            steps {
                sh '''
                chmod +x scripts/*.sh
                '''
            }
        }

        stage('Create Deployment Package') {
            steps {
                sh '''
                zip -r deployment.zip . -x "*.git*"
                '''
            }
        }

        stage('Upload to S3') {
            steps {
                sh '''
                aws s3 cp deployment.zip \
                s3://sourav-codedeploy-bucket/deployment.zip \
                --region ap-south-2
                '''
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                aws deploy create-deployment \
                --application-name Microservice-App-sourav \
                --deployment-group-name Microservice-DG \
                --deployment-config-name CodeDeployDefault.AllAtOnce \
                --s3-location bucket=sourav-codedeploy-bucket,bundleType=zip,key=deployment.zip \
                --region ap-south-2
                '''
            }
        }
    }

    post {

        success {
            echo 'Deployment completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check console logs.'
        }
    }
}
