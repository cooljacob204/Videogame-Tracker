pipeline {
  agent {
    node {
      label 'docker'
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