#!/bin/bash
set -e -u -o pipefail

ver="$1"
if [ -z "$ver" ]; then
  echo "usage: $0 vX.Y" >&2
  exit 1
fi

cd "$(dirname "$0")/.."
mkdir -p "$ver"

api_user=""
if [ -n "${GITHUB_API_USER:-}" ]; then
    api_user="${GITHUB_API_USER}@"
fi

okd_download_base_url=""
version=""
archive=""
shasum=""
oc_tool_copy_command=""
if [[ $ver == 'v4'* ]]; then
  # OpenShift v4
  okd_download_base_url="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp"
  archive="openshift-client-linux"
  shasum=""
  version="latest-${ver:1}"
  oc_tool_copy_command='mv -v "/tmp/oc" /bin/'
else
  # OpenShift v3
  okd_download_base_url="https://github.com/openshift/origin/releases/download"
  version=$(curl -sS https://${api_user}api.github.com/repos/openshift/origin/releases \
    | jq --arg ver "$ver" --raw-output \
        '.[]| select((.prerelease|not) and (.tag_name|startswith($ver))) | .tag_name' \
    | head -n 1)
  url="https://github.com/openshift/origin/releases/download/${version}/CHECKSUM"
  while read -r sha filename; do \
    shasum=${sha}
    archive="$(basename "$filename")"
    archive=${archive%.tar.gz}
  done <<<$(curl -sSL "$url" | grep 'client-tools.*linux-64bit.tar.gz$')
  oc_tool_copy_command='mv -v "/tmp/${ARCHIVE}/oc" /bin/'
fi

helm2_version=$(curl -sS https://${api_user}api.github.com/repos/helm/helm/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | sed '/v3\./d' \
  | head -n 1)
helm3_version=$(curl -sS https://${api_user}api.github.com/repos/helm/helm/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | sed '/v2\./d' \
  | head -n 1)

# Pinned for the time being, see https://github.com/kubernetes-sigs/kustomize/issues/3412
kustomize_version=v3.8.9
# kustomize_version=$(curl -sS https://${api_user}api.github.com/repos/kubernetes-sigs/kustomize/releases \
#   | jq --raw-output \
#       '.[]| select(.prerelease|not) | .tag_name' \
#   | grep '^kustomize/' \
#   | sed -e 's#^kustomize/##' -e '/-pre/d' \
#   | head -n 1)

seiso_version=$(curl -sS https://${api_user}api.github.com/repos/appuio/seiso/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | head -n 1)

kubeval_version=$(curl -sS https://${api_user}api.github.com/repos/instrumenta/kubeval/releases \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | head -n 1)

helm2_shasum=$(curl -sS https://get.helm.sh/helm-${helm2_version}-linux-amd64.tar.gz.sha256)
helm3_shasum=$(curl -sS https://get.helm.sh/helm-${helm3_version}-linux-amd64.tar.gz.sha256sum \
  | cut -f 1 -d ' ')

kustomize_shasum=$(curl -sSL https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize/${kustomize_version}/checksums.txt \
  | grep linux_amd64 \
  | cut -f 1 -d ' ')

seiso_shasum=$(curl -sSL https://github.com/appuio/seiso/releases/download/${seiso_version}/checksums.txt \
  | grep linux_amd64$ \
  | cut -f 1 -d ' ')

kubeval_shasum=$(curl -sSL https://github.com/instrumenta/kubeval/releases/download/${kubeval_version}/checksums.txt \
  | grep linux-amd64 \
  | cut -f 1 -d ' ')

sops_version=$(curl -sSL https://${api_user}api.github.com/repos/mozilla/sops/releases  \
  | jq --raw-output \
      '.[]| select(.prerelease|not) | .tag_name' \
  | head -n 1)

echo "Newest versions for ${ver} release:"
echo "- oc: ${version}"
echo "- helm2: ${helm2_version} (shasum: ${helm2_shasum})"
echo "- helm3: ${helm3_version} (shasum: ${helm3_shasum})"
echo "- kustomize: ${kustomize_version} (shasum: ${kustomize_shasum})"
echo "- seiso: ${seiso_version} (shasum: ${seiso_shasum})"
echo "- kubeval: ${kubeval_version} (shasum: ${kubeval_shasum})"
echo "- sops: ${sops_version}"

sed \
  -e "s/%%VERSION%%/${version}/" \
  -e "s/%%HELM2_VERSION%%/${helm2_version}/" \
  -e "s/%%HELM3_VERSION%%/${helm3_version}/" \
  -e "s/%%KUSTOMIZE_VERSION%%/${kustomize_version}/" \
  -e "s/%%SEISO_VERSION%%/${seiso_version}/" \
  -e "s/%%KUBEVAL_VERSION%%/${kubeval_version}/" \
  -e "s/%%SOPS_VERSION%%/${sops_version}/" \
  -e "s@%%OKD_DOWNLOAD_BASE_URL%%@${okd_download_base_url}@" \
  -e "s@%%ARCHIVE%%@${archive}@" \
  -e "s/%%SHA256SUM%%/${shasum}/" \
  -e "s@%%OC_TOOL_COPY_COMMAND%%@${oc_tool_copy_command}@" \
  -e "s/%%HELM2_SHA256SUM%%/${helm2_shasum}/" \
  -e "s/%%HELM3_SHA256SUM%%/${helm3_shasum}/" \
  -e "s/%%KUSTOMIZE_SHA256SUM%%/${kustomize_shasum}/" \
  -e "s/%%SEISO_SHA256SUM%%/${seiso_shasum}/" \
  -e "s/%%KUBEVAL_SHA256SUM%%/${kubeval_shasum}/" \
  src/Dockerfile > "${ver}/Dockerfile"
