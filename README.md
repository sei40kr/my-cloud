# my-cloud

## Install microk8s

```sh
sudo snap install microk8s --classic
```

## Enable microk8s addons
```
microk8s.enable dashboard dns storage
```

## Install WordPress

```sh
helm install -f wordpress/values-production.yml --name wordpress stable/wordpress
```
