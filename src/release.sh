#!/bin/sh

set -e

ver="$1"
if [ -z "$ver" ]; then
  echo "usage: $0 vX.Y" >&2
  exit 1
fi

cd "$(dirname "$0")/.."
mkdir -p "$ver"

version=$(curl -sS https://api.github.com/repos/openshift/origin/releases \
  | jq --arg ver "$ver" --raw-output \
      '.[]| select((.prerelease|not) and (.tag_name|startswith($ver))) | .tag_name' \
  | head -n 1)

helm_version=$(curl -sS https://api.github.com/repos/helm/helm/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | sed '/v3\./d' \
  | head -n 1)

kustomize_version=$(curl -sS https://api.github.com/repos/kubernetes-sigs/kustomize/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | grep '^kustomize/' \
  | sed -e 's#^kustomize/##' -e '/-pre/d' \
  | head -n 1)

kubeval_version=$(curl -sS https://api.github.com/repos/instrumenta/kubeval/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | head -n 1)

helm_shasum=$(curl -sS https://storage.googleapis.com/kubernetes-helm/helm-${helm_version}-linux-amd64.tar.gz.sha256)

kustomize_shasum=$(curl -sSL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${kustomize_version}/checksums.txt \
  | head -n 1 \
  | cut -f 1 -d ' ')

kubeval_shasum=$(curl -sSL https://github.com/instrumenta/kubeval/releases/download/${kubeval_version}/checksums.txt \
  | sed -n 5p \
  | cut -f 1 -d ' ')

sops_version=$(curl -sSL https://api.github.com/repos/mozilla/sops/releases  \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | head -n 1)

echo "Newest versions for ${ver} release:"
echo "- oc: ${version}"
echo "- helm: ${helm_version} (shasum: ${helm_shasum})"
echo "- kustomize: ${kustomize_version} (shasum: ${kustomize_shasum})"
echo "- kubeval: ${kubeval_version} (shasum: ${kubeval_shasum})"
echo "- sops: ${sops_version}"

url="https://github.com/openshift/origin/releases/download/${version}/CHECKSUM"
curl -sSL "$url" \
  | grep 'client-tools.*linux-64bit.tar.gz$' \
  | while read -r shasum filename; do \
      archive="$(basename "$filename")"
      archive=${archive%.tar.gz}
      sed \
        -e "s/%%VERSION%%/${version}/" \
        -e "s/%%HELM_VERSION%%/${helm_version}/" \
        -e "s/%%KUSTOMIZE_VERSION%%/${kustomize_version}/" \
        -e "s/%%KUBEVAL_VERSION%%/${kubeval_version}/" \
        -e "s/%%SOPS_VERSION%%/${sops_version}/" \
        -e "s/%%ARCHIVE%%/${archive}/" \
        -e "s/%%SHA256SUM%%/${shasum}/" \
        -e "s/%%HELM_SHA256SUM%%/${helm_shasum}/" \
        -e "s/%%KUSTOMIZE_SHA256SUM%%/${kustomize_shasum}/" \
        -e "s/%%KUBEVAL_SHA256SUM%%/${kubeval_shasum}/" \
        src/Dockerfile > "${ver}/Dockerfile"
    done
