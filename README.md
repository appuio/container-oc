# container-oc

[![dockeri.co](http://dockeri.co/image/appuio/oc)](https://hub.docker.com/r/appuio/oc/)

[![Build Status](https://img.shields.io/docker/cloud/build/appuio/oc.svg)](https://hub.docker.com/r/appuio/oc/builds
) [![GitHub issues](https://img.shields.io/github/issues-raw/appuio/container-oc.svg)](https://github.com/appuio/container-oc/issues
) [![GitHub PRs](https://img.shields.io/github/issues-pr-raw/appuio/container-oc.svg)](https://github.com/appuio/container-oc/pulls
) [![License](https://img.shields.io/github/license/appuio/container-oc.svg)](https://github.com/appuio/container-oc/blob/master/LICENSE)

[OpenShift][] client `oc` in a container image.

A container image that can be used in CI/CD pipelines to deploy apps to OpenShift.

Also ships the binaries for `helm`, `kustomize`, `kubeval`, `sops` and the [moreutils](
https://joeyh.name/code/moreutils/) package, for your convenience.

## Container Images

The built images are available from [Docker Hub][hub] and [Red Hat Quay.io][quay]

- `docker.io/appuio/oc:v4.11`
- `quay.io/appuio/oc:v4.11`
- `docker.io/appuio/oc:v4.10`
- `quay.io/appuio/oc:v4.10`
- `docker.io/appuio/oc:v4.9`
- `quay.io/appuio/oc:v4.9`
- `docker.io/appuio/oc:v4.8`
- `quay.io/appuio/oc:v4.8`

## Development

- only hack files in `src/`
- run `export GITHUB_API_USER=<your-github-user-name>:<your-revocable-personal-access-token>`
  (see [GitHub API rate limiting][api-limit]; create a token at https://github.com/settings/tokens)
- run `make` to regenerate Dockerfiles
- run `make images` to verify that images are building successfully

If you see errors like `jq: error (at <stdin>:4): Cannot index string with string "prerelease"` check your credentials or see if the GitHub API calls return a valid response.

## Update OpenShift CLI Versions

To add or remove a version of `oc`, update the list of versions in the following places:

- `Makefile`
- `README.md`
- `.github/workflows/build.yml`

And then run `make`.

> [APPUiO](https://appuio.ch) -
> GitHub [@appuio](https://github.com/appuio) -
> Twitter [@appuio](https://twitter.com/appuio)

[hub]: https://hub.docker.com/r/appuio/oc/tags
[quay]: https://quay.io/repository/appuio/oc?tab=tags
[OpenShift]: https://github.com/openshift/origin
[api-limit]: https://developer.github.com/v3/#rate-limiting
[seiso]: https://github.com/appuio/seiso
