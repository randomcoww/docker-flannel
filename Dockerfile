FROM golang:alpine as BUILD

WORKDIR /go/src/github.com/coreos

RUN set -x \
  \
  && apk add --no-cache \
    git \
    g++ \
    linux-headers \
  \
  && git clone \
    https://github.com/coreos/flannel.git \
  && cd flannel \
  && mkdir bin \
  && CGO_ENABLED=1 GOOS=linux \
    go build -v -ldflags '-s -w' -o bin/flanneld

FROM alpine:edge

COPY --from=BUILD /go/src/github.com/coreos/flannel/bin/ /opt/bin/
RUN set -x \
  \
  && apk add --no-cache \
    iproute2 \
    net-tools \
    ca-certificates \
    iptables \
    strongswan \
  \
  && update-ca-certificates

ENTRYPOINT ["/opt/bin/flanneld"]
