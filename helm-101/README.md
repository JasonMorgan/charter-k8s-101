# Helm 101

## What is Helm

A package manager for kubernetes. You can find more detailed information [here](https://helm.sh/).

### Helm Components

#### Helm

The Helm Client is a command-line client for end users. The client is responsible for the following domains:

* Local chart development
* Managing repositories
* Interacting with the Tiller server
  * Sending charts to be installed
  * Asking for information about releases
  * Requesting upgrading or uninstalling of existing releases

#### Tiller

The Tiller Server is an in-cluster server that interacts with the Helm client, and interfaces with the Kubernetes API server. The server is responsible for the following:

* Listening for incoming requests from the Helm client
* Combining a chart and configuration to build a release
* Installing charts into Kubernetes, and then tracking the subsequent release
* Upgrading and uninstalling charts by interacting with Kubernetes

#### Chart

A Chart is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster. Think of it like the Kubernetes equivalent of a Homebrew formula, an Apt dpkg, or a Yum RPM file.

#### Repository

A Repository is the place where charts can be collected and shared. It’s like Perl’s CPAN archive or the Fedora Package Database, but for Kubernetes packages.

#### Release

A Release is an instance of a chart running in a Kubernetes cluster. One chart can often be installed many times into the same cluster. And each time it is installed, a new release is created. Consider a MySQL chart. If you want two databases running in your cluster, you can install that chart twice. Each one will have its own release, which will in turn have its own release name.

### Helm and RBAC

Using helm with [RBAC](https://docs.helm.sh/using_helm/#tiller-namespaces-and-rbac).

### Search

When you first install Helm, it is preconfigured to talk to the official Kubernetes charts repository. This repository contains a number of carefully curated and maintained charts. This chart repository is named stable by default. You can find more details about using search [here](https://docs.helm.sh/using_helm/#helm-search-finding-charts).

### Install an App

Helm simplifies the process of installing an app on kubernetes. You can find more details about installing apps [here](https://docs.helm.sh/using_helm/#helm-install-installing-a-package)

### Upgrade an App

Helm provides a facility for changing a deployed application. You can find more [here](https://docs.helm.sh/using_helm/#helm-upgrade-and-helm-rollback-upgrading-a-release-and-recovering-on-failure).

### Delete an App

Like any other package manager Helm has a facility for deleting deployed apps. It's worth going through the documentation as you look at managing the SDLC for helm charts. You can view the documentation [here](https://docs.helm.sh/using_helm/#helm-delete-deleting-a-release)
