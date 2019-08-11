SHELL := /bin/sh

GUNICORN_PID_FILE := gunicorn.pid
GUNICORN_PID = "$$(cat ${GUNICORN_PID_FILE})"

.DEFAULT_GOAL := dev/run

.PHONY: dev/install
dev/install:
	@pipenv install -d

.PHONY: dev/run
dev/run: dev/stop
	@pipenv run \
		gunicorn \
			-b 0:5000 \
			-k eventlet \
			-D \
			-p ${GUNICORN_PID_FILE} \
			api:api

.PHONY: dev/status
dev/status:
	@if [ -e ${GUNICORN_PID_FILE} ]; then ps -p ${GUNICORN_PID}; fi

.PHONY: dev/reload
dev/reload:
	@if [ -e ${GUNICORN_PID_FILE} ]; then kill -s HUP ${GUNICORN_PID}; fi

.PHONY: dev/stop
dev/stop:
	@if [ -e ${GUNICORN_PID_FILE} ]; then \
		kill -s TERM ${GUNICORN_PID}; \
	fi

.PHONY: dev/remove
dev/remove:
	@pipenv --rm
