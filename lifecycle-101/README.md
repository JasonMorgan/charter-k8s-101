# Kubernetes Application Lifecycle

## Configuring a Cluster

* Connect to the API
* Apply configurations

## Upgrading an App

### Scenario: 3rd party provides container image

Producer side:

* Make an updated version of the container
* Tag the Image
* Add 2.0 to docker hub

Consumer side:

* Pull the image from docker hub
* Tag the image for my registry
* post image to harbor
* review scan
* update deployment manifest
* apply changes
* watch rollout
* rollback - if required
