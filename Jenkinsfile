pipeline {
  agent {
    node {
      label 'master'
    }

  }
  stages {
    stage('Checkout Code') {
      steps {
        checkout scm
      }
    }
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
        kubernetesDeploy(kubeconfigId: 'd679dcbe-d794-4fad-821c-8e8c85983901',               // REQUIRED
                 configs: 'https://raw.githubusercontent.com/cooljacob204/sinatra-project/master/deployment.yaml', // REQUIRED
          )
      }
    }
  }
}
