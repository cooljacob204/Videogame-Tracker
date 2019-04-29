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
  environment {
    registry = "cooljacob204/videogame-tracker"
    registryCredential = '87198f1c-56ee-47ab-bcf4-a7033bf802c3'
  }
  stages {
    stage('build') {
      steps {
        setBuildStatus("Build Pending", "PENDING")
        sh docker.build registry + ":v$BUILD_ID"
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
