pipeline {
  agent {
    node {
      label 'test'
    }

  }
  stages {
    stage('build') {
      steps {
        sh 'docker build .'
      }
    }
  }
}