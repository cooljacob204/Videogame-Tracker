pipeline {
  agent {
    node {
      label 'docker'
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