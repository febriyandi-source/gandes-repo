pipeline {
    agent any

    environment {
        // Define your Alibaba Cloud Container Registry details
        ACR_REGISTRY = 'registry-intl.ap-southeast-5.aliyuncs.com'  // Replace with your region
        ACR_NAMESPACE = 'gandes-test'                   // Replace with your namespace
        IMAGE_NAME = 'test-form-jenkins'                     // Replace with your image name
        IMAGE_TAG = 'latest'                               // Replace with your desired tag
        DOCKER_IMAGE = "${ACR_REGISTRY}/${ACR_NAMESPACE}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your source code from SCM (e.g., Git)
                git branch: 'main', url: 'https://github.com/febriyandi-source/gandes-repo.git'
            }
        }

        stage('Login to Alibaba Cloud Container Registry') {
            steps {
                script {
                    // Use Jenkins credentials to login to ACR
                    withCredentials([usernamePassword(credentialsId: 'alibaba-cloud-credentials', 
                                                      usernameVariable: 'ACR_USERNAME', 
                                                      passwordVariable: 'ACR_PASSWORD')]) {
                        sh """
                            echo "Logging into Alibaba Cloud Container Registry..."
                            docker login --username ${ACR_USERNAME} --password ${ACR_PASSWORD} ${ACR_REGISTRY}
                        """
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh """
                        echo "Building Docker image..."
                        docker build -t ${DOCKER_IMAGE} .
                    """
                }
            }
        }

        stage('Push Docker Image to ACR') {
            steps {
                script {
                    // Push the Docker image to Alibaba Cloud Container Registry
                    sh """
                        echo "Pushing Docker image to Alibaba Cloud Container Registry..."
                        docker push ${DOCKER_IMAGE}
                    """
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed."
        }
    }
}
