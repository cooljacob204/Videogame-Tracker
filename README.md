# Videogame-Tracker
Sinatra Portfolio project and a CI/CD sandbox for experimenting with Jenkins, Docker and Kubernetes.

## Hosting
### https://videogame-tracker.lfp2.gg
I have the app currently hosted on my Google Kubernetes Engine cluster. The docker image is hosted at cooljacob204/videogame-tracker.

I have a deployment running Jenkins that waits for a push from Github whenever a new commit is made on the master branch. When it receives that push it builds a new docker image, pushes it to the hub then deploys it to the cluster.

The deployment has a readiness probe running at '/'. If GKE doesn't detect the updated app running after the default amount of time Kubernetes will cancels the deployment and roll back any pods that were updated.
