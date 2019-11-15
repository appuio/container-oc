# container-oc

[![Docker Build Status](https://img.shields.io/docker/build/appuio/oc.svg)](https://hub.docker.com/r/appuio/oc/)

[OpenShift][] client `oc` in a container image.

A container image that can be used in CI/CD pipelines to deploy apps to OpenShift.

Also ships the binaries for `helm`, `kustomize`, `kubeval` and `sops`, for your convenience.

## Container Images

The built images are available from [Docker Hub][hub]

- `docker.io/appuio/oc:v3.6`
- `docker.io/appuio/oc:v3.7`
- `docker.io/appuio/oc:v3.9`
- `docker.io/appuio/oc:v3.10`
- `docker.io/appuio/oc:v3.11`

## Development

- only hack files in `src/`
- run `make` to regenerate Dockerfiles
- run `make images` to verify that images are building successfully

> [APPUiO](https://appuio.ch) -
> GitHub [@appuio](https://github.com/appuio) -
> Twitter [@appuio](https://twitter.com/appuio)

[hub]: https://hub.docker.com/r/appuio/oc/tags
[OpenShift]: https://github.com/openshift/origin
