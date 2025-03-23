VERSION:=$(shell cat VERSION)

IMAGE_NAME ?= prometheus-example-app

LDFLAGS="-X main.appVersion=$(VERSION)"

.PHONY : all build image

all: build

build:
	CGO_ENABLED=0 go build -ldflags=$(LDFLAGS) -o prometheus-example-app --installsuffix cgo main.go

image:
	docker build -t "gesarki/$(IMAGE_NAME):$(VERSION)" -t "gesarki/prometheus-example-app:latest" .
