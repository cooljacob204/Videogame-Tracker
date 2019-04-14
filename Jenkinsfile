pipeline {
  agent {
    node {
      label 'master'
    }
  }
  triggers {
    pollSCM ''
  }
  stages {
    stage('build') {
      steps {
        sh 'docker build -t cooljacob204/videogame-tracker:v$BUILD_ID .'
      }
    }
    stage('Deploy Dockerhub') {
      steps {
        sh 'docker push cooljacob204/videogame-tracker:v$BUILD_ID'
      }
    }
    stage('Deploy Kubernetes') {
      steps {
        kubernetesDeploy(kubeconfigId: 'd679dcbe-d794-4fad-821c-8e8c85983901', configs: 'deployment.yaml')
      }
    }
  }
}
