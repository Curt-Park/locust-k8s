# locust-k8s
Locust on k8s example for scalable load tests

## Preparation
1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/) to generate a local cluster.
2. [Install the latest Skaffold](https://github.com/GoogleContainerTools/skaffold/releases) for easy and repeatable Kubernetes development.

## How to play

#### 1. Create a k8s cluster
```
make cluster
```

#### 2. Execute locust
```
skaffold dev
```

#### 3. Run FastAPI Server
```
make api
```

## Delete the cluster
```
make finalize
```
