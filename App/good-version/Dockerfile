FROM golang:1.24 AS builder

WORKDIR /go/src/github.com/gesarki/prometheus-example-app

COPY . /go/src/github.com/gesarki/prometheus-example-app

RUN CGO_ENABLED=0 go build -o prometheus-example-app --installsuffix cgo main.go

FROM quay.io/prometheus/busybox:latest

COPY --from=builder /go/src/github.com/gesarki/prometheus-example-app/prometheus-example-app \
  /bin/prometheus-example-app

ENTRYPOINT ["/bin/prometheus-example-app"]