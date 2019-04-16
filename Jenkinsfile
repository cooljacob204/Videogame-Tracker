void setBuildStatus(String message, String state) {
  step([
      $class: "GitHubCommitStatusSetter",
      reposSource: [$class: "ManuallyEnteredRepositorySource", url: "https://github.com/cooljacob204/sinatra-project"],
      contextSource: [$class: "ManuallyEnteredCommitContextSource", context: "ci/jenkins/build-status"],
      errorHandlers: [[$class: "ChangingBuildStatusErrorHandler", result: "UNSTABLE"]],
      statusResultSource: [ $class: "ConditionalStatusResultSource", results: [[$class: "AnyBuildResult", message: message, state: state]] ]
  ]);
}


pipeline {
  agent {
    node {
      label 'master'
    }
  }
  triggers {
    pollSCM ''
  }
  stages {
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
        kubernetesDeploy(kubeconfigId: 'd679dcbe-d794-4fad-821c-8e8c85983901', configs: 'deployment.yaml')
      }
    }
  }
  post {
      success {
          setBuildStatus("Build succeeded", "SUCCESS");
      }
      failure {
          setBuildStatus("Build failed", "FAILURE");
      }
   }
}
