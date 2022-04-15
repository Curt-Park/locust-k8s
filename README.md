# locust-k8s
a Locust on k8s example for scalable load tests.

## Preparation
0. [Install Docker](https://docs.docker.com/engine/install/).
1. Install [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl).
2. [Install Minikube](https://minikube.sigs.k8s.io/docs/start/) to generate a local cluster.
3. [Install the latest Skaffold](https://github.com/GoogleContainerTools/skaffold/releases) for easy and repeatable Kubernetes development.

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
curl localhost/random-number  # check the server is running
```

#### 4. Load Tests
Go to http://localhost:8089, and set the host address and the number of v-users.

<img width="1275" alt="" src="https://user-images.githubusercontent.com/14961526/163500998-2ba3f020-9796-4338-bb1d-bdee02f54798.png">

k8s will auto-scale pods to make concurrent requests if needed.

```bash
$ kubectl get hpa --watch       

NAME                REFERENCE                  TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
locust-worker-hpa   Deployment/locust-worker   <unknown>/50%   1         10        1          21s
locust-worker-hpa   Deployment/locust-worker   73%/50%         1         10        1          45s
locust-worker-hpa   Deployment/locust-worker   73%/50%         1         10        2          60s
locust-worker-hpa   Deployment/locust-worker   91%/50%         1         10        2          75s
locust-worker-hpa   Deployment/locust-worker   81%/50%         1         10        2          90s
locust-worker-hpa   Deployment/locust-worker   78%/50%         1         10        2          105s
locust-worker-hpa   Deployment/locust-worker   85%/50%         1         10        4          2m
locust-worker-hpa   Deployment/locust-worker   63%/50%         1         10        4          2m15s
locust-worker-hpa   Deployment/locust-worker   38%/50%         1         10        4          2m30s
```

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
