# Docker registry for Raspberry Pi (and arms)

Build of the official [docker distribution](https://github.com/docker/distribution) version for arm platforms.

## Running the registry
```
docker run -d -v <volume>:/var/lib/registry -p 5000:5000 vsellier/docker-registry-arm
```

The default [dev configuration](https://github.com/docker/distribution/blob/master/cmd/registry/config-dev.yml) is installed.
To override it, add ``-v <path to your file>:/etc/docker/registry/config.yml``

The official documentation is available [here](https://docs.docker.com/registry/)


## Running as a registry mirror

If you want to start a registry to act as a mirror of the official docker hub execute :
```
docker run -d -v <volume>:/var/lib/registry -p 5000:5000 -e REGISTRY_PROXY_REMOTEURL=https://registry-1.docker.io vsellier/docker-registry-arm
```

On your local docker, configure the mirror as explained [here](https://docs.docker.com/registry/recipes/mirror/)

## Versions

| Versions   | Official release |
|------------|------------------|
| latest     | https://github.com/docker/distribution/tree/master |
| 2.7.1      | https://github.com/docker/distribution/releases/tag/v2.7.1 |
| 2.7.0      | https://github.com/docker/distribution/releases/tag/v2.7.0 |
| 2.7.0-rc.0 | https://github.com/docker/distribution/releases/tag/v2.7.0-rc.0 |
| 2.6.2      | https://github.com/docker/distribution/releases/tag/v2.6.2 |
| 2.6.1      | https://github.com/docker/distribution/releases/tag/v2.6.1 |



