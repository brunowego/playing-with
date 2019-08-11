SHELL := /bin/sh

DOCKER_BUILD_OPTS ?=
DOCKER_RUN_OPTS ?=
DOCKER_REPO := brunowego
DOCKER_IMAGE := python-flask-ml-score-api

.DEFAULT_GOAL := docker/build

.PHONY: docker/build
docker/build:
	@docker build \
		${DOCKER_BUILD_OPTS} \
		-t $(DOCKER_REPO)/$(DOCKER_IMAGE):latest .
	@$(MAKE) docker/clean

.PHONY: docker/run
docker/run:
	@docker run -d \
		${DOCKER_RUN_OPTS} \
		-p 5000:5000 \
		--name $(DOCKER_IMAGE) \
		--restart always \
		$(DOCKER_REPO)/$(DOCKER_IMAGE):latest

.PHONY: docker/status
docker/status:
	@docker ps -af "name=$(DOCKER_IMAGE)"

.PHONY: docker/remove
docker/remove:
	@docker rm -f $(DOCKER_IMAGE)

.PHONY: docker/push
docker/push:
	@docker push $(DOCKER_REPO)/$(DOCKER_IMAGE):latest

.PHONY: docker/clean
docker/clean:
	@docker image prune -f
