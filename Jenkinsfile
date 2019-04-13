pipeline {
  agent {
    docker {
      image 'docker'
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
        sh 'docker build .'
      }
    }
  }
}