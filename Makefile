export GIT_SHA1             := $(shell git rev-parse --short HEAD)
export DOCKER_IMAGE_NAME    := icinga2
export DOCKER_NAME_SPACE    := ${USER}
export DOCKER_VERSION       ?= latest
export BUILD_DATE           := $(shell date +%Y-%m-%d)
export BUILD_VERSION        := $(shell date +%y%m)
export BUILD_TYPE           ?= stable
export ICINGA2_VERSION      ?= $(shell hooks/latest-version.sh)
export CERT_SERVICE_TYPE    ?= stable
export CERT_SERVICE_VERSION ?= 0.20.0

export BUILD_IMAGE          ?= ${DOCKER_NAME_SPACE}/icinga2:${DOCKER_VERSION}-base


.PHONY: build shell run exec start stop clean

default: build

build: base-build master-build satellite-build

base-build:
	@hooks/build

master-build:
	@hooks/build master

satellite-build:
	@hooks/build satellite

base-shell:
	@hooks/shell base

master-shell:
	@hooks/shell master

satellite-shell:
	@hooks/shell satellite

run:
	@hooks/run

exec:
	@hooks/exec

start:
	@hooks/start

stop:
	@hooks/stop

clean:
	@hooks/clean

compose-file:
	@hooks/compose-file

publish-base:
	@hooks/publish

linter:
	@tests/linter.sh

integration_test:
	@tests/integration_test.sh

test: linter integration_test
