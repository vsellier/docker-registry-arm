FROM golang:1.12.3 as build

ENV DOCKER_BUILDTAGS include_oss include_gcs

RUN set -ex \
    && apt update && apt install -y make git 
    
WORKDIR /go/src/github.com/docker
ENV GIT_VERSION=master

RUN git clone --single-branch https://github.com/docker/distribution.git -b ${GIT_VERSION}

WORKDIR /go/src/github.com/docker/distribution

RUN make PREFIX=/go clean binaries

FROM golang:1.12.3

RUN mkdir -p /etc/docker/registry
COPY --from=build /go/src/github.com/docker/distribution/bin/registry /usr/bin/registry
COPY --from=build /go/src/github.com/docker/distribution/cmd/registry/config-dev.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]

EXPOSE 5000

ENTRYPOINT ["/usr/bin/registry"]

CMD ["serve", "/etc/docker/registry/config.yml"]
