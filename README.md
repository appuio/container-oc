# container-oc

[![dockeri.co](http://dockeri.co/image/appuio/oc)](https://hub.docker.com/r/appuio/oc/)

[![Build Status](https://img.shields.io/docker/cloud/build/appuio/oc.svg)](https://hub.docker.com/r/appuio/oc/builds
) [![GitHub issues](https://img.shields.io/github/issues-raw/appuio/container-oc.svg)](https://github.com/appuio/container-oc/issues
) [![GitHub PRs](https://img.shields.io/github/issues-pr-raw/appuio/container-oc.svg)](https://github.com/appuio/container-oc/pulls
) [![License](https://img.shields.io/github/license/appuio/container-oc.svg)](https://github.com/appuio/container-oc/blob/master/LICENSE)

[OpenShift][] client `oc` in a container image.

A container image that can be used in CI/CD pipelines to deploy apps to OpenShift.

Also ships the binaries for `helm`, `kustomize`, `kubeval` and `sops`, for your convenience.

## Container Images

The built images are available from [Docker Hub][hub]

- `docker.io/appuio/oc:v4.5`
- `docker.io/appuio/oc:v4.4`
- `docker.io/appuio/oc:v4.3`
- `docker.io/appuio/oc:v4.2`
- `docker.io/appuio/oc:v4.1`
- `docker.io/appuio/oc:v3.11`
- `docker.io/appuio/oc:v3.10`
- `docker.io/appuio/oc:v3.9`
- `docker.io/appuio/oc:v3.7`
- `docker.io/appuio/oc:v3.6`

## Caveats

- This image includes both Helm v2 and v3. Helm v3 is available as `helm3`, v2 as `helm2`
  and `helm` symlinks to `helm3`.

## Development

- only hack files in `src/`
- run `export GITHUB_API_USER=<your-github-user-name>:<your-revocable-personal-access-token>`
  (see [GitHub API rate limiting][api-limit]; create a token at https://github.com/settings/tokens)
- run `make` to regenerate Dockerfiles
- run `make images` to verify that images are building successfully

If you see errors like `jq: error (at <stdin>:4): Cannot index string with string "prerelease"` check your credentials or see if the GitHub API calls return a valid response.

> [APPUiO](https://appuio.ch) -
> GitHub [@appuio](https://github.com/appuio) -
> Twitter [@appuio](https://twitter.com/appuio)

[hub]: https://hub.docker.com/r/appuio/oc/tags
[OpenShift]: https://github.com/openshift/origin
[api-limit]: https://developer.github.com/v3/#rate-limiting
[seiso]: https://github.com/appuio/seiso
