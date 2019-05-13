# Videogame-Tracker
Sinatra Portfolio project and a CI/CD sandbox for experimenting with Jenkins, Docker and Kubernetes.

## Hosting
### https://videogame-tracker.lfp2.gg
I have the app currently hosted on Google Kubernetes Engine. The docker image is hosted at cooljacob204/videogame-tracker.

My cluster has a Jenkins deployment that waits for a push from Github when a new commit is made on this project's master branch. When it receives that push it builds a new docker image, pushes it to dockerhub then deploys it to the cluster.

This project's deployment has a readiness probe running at '/'. If GKE doesn't detect the updated app running after the default amount of time Kubernetes will cancel the deployment and roll back any pods that were updated.
