# Videogame-Tracker
Sinatra Portfolio project and a CI/CD sandbox for experimenting with Jenkins, Docker and Kubernetes.

## Hosting
### https://videogame-tracker.lfp2.gg

App is hosted in a container on my local network in a box running [unraid](https://unraid.net/). Requests are routed through an external Digital Ocean droplet using Haproxy to route to a specified backend which then goes into a Wireguard tunnel which is connected to my internal container network that contains all of my applications.

I am using certbot, haproxy and cron bi-monthly cronjob to serve and maintain my SSL certs.
