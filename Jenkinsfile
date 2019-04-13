pipeline {
  agent {
    docker {
      image '_/docker:latest'
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