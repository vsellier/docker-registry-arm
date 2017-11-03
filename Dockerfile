FROM golang:1.9

ENV DISTRIBUTION_DIR /go/src/github.com/docker/distribution
ENV DOCKER_BUILDTAGS include_oss include_gcs

RUN set -ex \
    && apt update && apt install make git  \
    && rm -rf /var/lib/apt/lists

WORKDIR /go/src/github.com/docker
ENV GIT_VERSION=master

RUN git clone --single-branch https://github.com/docker/distribution.git -b ${GIT_VERSION}
WORKDIR $DISTRIBUTION_DIR
RUN mkdir -p /etc/docker/registry && cp -v cmd/registry/config-dev.yml /etc/docker/registry/config.yml
RUN make PREFIX=/go clean binaries

VOLUME ["/var/lib/registry"]
EXPOSE 5000
ENTRYPOINT ["registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
