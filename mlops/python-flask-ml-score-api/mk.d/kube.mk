SHELL := /bin/sh

.DEFAULT_GOAL := kube/rollout

.PHONY: kube/create
kube/create:
	@kubectl create -k ./.k8s/api

.PHONY: kube/rollout
kube/rollout:
	@kubectl rollout status deploy/python-flask-ml-score-api -n ml-serving

.PHONY: kube/delete
kube/delete:
	@kubectl delete -k ./.k8s/api
