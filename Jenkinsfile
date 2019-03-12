pipeline {
  agent any
  environment {
    // Tag: latest
    BASE_IMAGE_LATEST = "ripl/libbot:latest"
    BUILD_IMAGE_LATEST = "ripl/libbot2-ros:latest"

    // Tag: trusty
    BASE_IMAGE_TRUSTY = "ripl/libbot:trusty"
    BUILD_IMAGE_TRUSTY = "ripl/libbot2-ros:trusty"
  }
  stages {
    stage('Update Base Image') {
      steps {
        sh 'docker pull $BASE_IMAGE_LATEST'

        sh 'docker pull $BASE_IMAGE_TRUSTY'
      }
    }
    stage('Build Image') {
      steps {
        sh 'docker build -t $BUILD_IMAGE_LATEST -f Dockerfile ./'

        sh 'docker build -t $BUILD_IMAGE_TRUSTY -f Dockerfile_trusty ./'
      }
    }
    stage('Push Image') {
      steps {
        withDockerRegistry(credentialsId: 'DockerHub', url: 'https://index.docker.io/v1/') {
          sh 'docker push $BUILD_IMAGE_LATEST'

          sh 'docker push $BUILD_IMAGE_TRUSTY'
        }
      }
    }
    stage('Clean up') {
      steps {
        sh 'docker rmi $BUILD_IMAGE_LATEST'
        sh 'docker rmi $BASE_IMAGE_LATEST'

        sh 'docker rmi $BUILD_IMAGE_TRUSTY'
        sh 'docker rmi $BASE_IMAGE_TRUSTY'

        cleanWs()
      }
    }
  }
}
