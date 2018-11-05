# container-oc

[![Docker Build Status](https://img.shields.io/docker/build/appuio/oc.svg)](https://hub.docker.com/r/appuio/oc/)

[OpenShift][] client `oc` in a container image.

The main goal of this project is to provide a container image that can be used in CI/CD pipelines to deploy apps to OpenShift.


## Container Images

The built images are available from [Docker Hub][hub]

- `appuio/oc:v3.6`
- `appuio/oc:v3.7`
- `appuio/oc:v3.9`
- `appuio/oc:v3.10`


## Development

- only hack files in `src/`
- use `make` to regenerate files


> [APPUiO](https://appuio.ch) -
> GitHub [@appuio](https://github.com/appuio) -
> Twitter [@appuio](https://twitter.com/appuio)

[hub]: https://hub.docker.com/r/appuio/oc/tags
[OpenShift]: https://github.com/openshift/origin
