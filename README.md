# my-cloud

## Install

### Install microk8s

```sh
sudo snap install microk8s --classic
```

### Enable microk8s addons
```
microk8s.enable dashboard dns storage
```

### Install Helm

```sh
brew install kubernetes-helm
helm init --history-max 200
```

### Install Jenkins

```sh
helm install -f jenkins/values.yml --name jenkins stable/jenkins
```

### Install WordPress

```sh
helm install -f wordpress/values-production.yml --name wordpress stable/wordpress
```
