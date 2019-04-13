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
        sh 'docker build -t cooljacob204/videogame-tracker:latest .'
        sh '''BUILD_ID=$(docker build -q -t foo . 2>/dev/null | awk \'/Successfully built/{print $NF}\')
'''
        sh 'docker tag cooljacob204/videogame:latest cooljacob204/videogame:v$BUILD_ID'
      }
    }
    stage('Deploy Dockerhub') {
      steps {
        sh 'docker push cooljacob204/videogame-tracker:v${env.BUILD_ID}'
      }
    }
  }
}