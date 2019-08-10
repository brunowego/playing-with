SHELL := /bin/sh

.PHONY: docker/prune
docker/prune:
	@docker system prune -f
	@docker volume prune -f
