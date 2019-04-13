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
        sh 'docker build .'
      }
    }
  }
}