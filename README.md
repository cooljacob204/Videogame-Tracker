# Videogame-Tracker
Sinatra Portfolio project and a CI/CD sandbox for experimenting with Jenkins, Docker and Kubernetes.

## Hosting
### https://videogame-tracker.lfp2.gg
I have the app currently hosted on my Google Kubernetes Engine cluster. It has 3 replicas and grabs the image from docker hub at cooljacob204/videogame-tracker.

I have a deployment running Jenkins that waits for a push from Github whenever a new commit is made on the master branch. When it receives that commit it builds a new docker image, pushes it to the hub then deploys it to the cluster.

The deployment has a readiness probe running at '/'. GKE does a rolling update of the 3 pods. If it doesn't detect the updated running app after the default amount of time Kubernetes will cancels the deployment and roll back any pods that were updated.
