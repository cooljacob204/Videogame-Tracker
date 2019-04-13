pipeline {
  agent {
    docker {
      image 'docker:latest'
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