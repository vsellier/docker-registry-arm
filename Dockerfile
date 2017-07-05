FROM armhf/golang:1.8-alpine

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV DOCKER_BUILDTAGS include_oss include_gcs

RUN set -ex \
    && apk add --no-cache make git

WORKDIR /go/src/github.com/docker
ENV REGISTRY_VERSION=master

RUN git clone --single-branch https://github.com/docker/distribution.git -b ${REGISTRY_VERSION}
WORKDIR $DISTRIBUTION_DIR
RUN mkdir -p /etc/docker/registry && cp -v cmd/registry/config-dev.yml /etc/docker/registry/config.yml
RUN make PREFIX=/go clean binaries

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]

