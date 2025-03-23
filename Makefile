GOOD_VERSION:=$(shell cat App/good-version/VERSION)
BAD_VERSION:=$(shell cat App/bad-version/VERSION)

IMAGE_NAME ?= prometheus-example-app

LDFLAGS="-X main.appVersion=$(VERSION)"

.PHONY : all build-bad image-bad build-good image-good

all: build-bad image-bad build-good image-good

build-bad:
	cd App/bad-version && \
	CGO_ENABLED=0 go build -ldflags=$(LDFLAGS) -o prometheus-example-app --installsuffix cgo main.go

build-good:
	cd App/good-version && \
	CGO_ENABLED=0 go build -ldflags=$(LDFLAGS) -o prometheus-example-app --installsuffix cgo main.go


image-good:
	cd App/good-version && \
	docker build -t "gesarki/$(IMAGE_NAME):$(GOOD_VERSION)" -t "gesarki/prometheus-example-app:good-version" .

image-bad:
	cd App/bad-version && \
	docker build -t "gesarki/$(IMAGE_NAME):$(BAD_VERSION)" -t "gesarki/prometheus-example-app:bad-version" .