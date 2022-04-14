PROFILE_NAME=locust

cluster:
	# https://github.com/kubernetes/minikube/issues/13656#issuecomment-1059270823
	minikube start --profile $(PROFILE_NAME) --extra-config=kubelet.housekeeping-interval=10s --memory=max --cpus=max
	minikube addons enable metrics-server --profile $(PROFILE_NAME)
	minikube addons list --profile $(PROFILE_NAME)
	eval $(minikube docker-env --profile=$(PROFILE_NAME))

finalize:
	minikube delete --profile $(PROFILE_NAME)

api:
	docker build -t test-server:latest server/.
	docker run -v $(PWD)/server:/app -p 8000:8000 test-server:latest
