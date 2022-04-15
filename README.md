# locust-k8s
a Locust on k8s example for scalable load tests.

## Preparation
0. [Install Docker](https://docs.docker.com/engine/install/).
1. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/) to generate a local cluster.
2. [Install the latest Skaffold](https://github.com/GoogleContainerTools/skaffold/releases) for easy and repeatable Kubernetes development.

## How to play

#### 1. Create a k8s cluster
```
make cluster
```

#### 2. Run locust master and workers
```
skaffold dev  # `ctrl + c` to terminate
```

#### 3. Run FastAPI Server
```
make api
curl localhost:8000/random-number  # check the server is running
```

#### 4. Load Tests
Go to http://localhost:8089, and set the host address and the number of v-users.

<img width="1278" alt="" src="https://user-images.githubusercontent.com/14961526/163497514-fe66daf1-0abc-4d80-bf3e-3a01b6af7bf3.png">

k8s will auto-scale pods to make concurrent requests if needed.

## Delete the cluster
```
make finalize
```

## Change the test scenario
Modify [k8s/configmap.yaml](k8s/configmap.yaml). `skaffold` will instantly apply the changes.

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: locust-configmap
data:
  locustfile.py: |
    from locust import FastHttpUser, between, task

    class QuickstartUser(FastHttpUser):

        wait_time = between(1, 3)

        @task
        def get_random_number(self):
            self.client.get("/random-number")
```

- Reference: http://docs.locust.io/en/stable/writing-a-locustfile.html

## Change api server
Modify [server/main.py](server/main.py).
