pipeline {
  agent {
    docker {
      image 'ubuntu:18.04'
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