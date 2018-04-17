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
      '.[]| select((.prerelease|not) and (.name|startswith($ver))) | .name' \
  | head -n 1)

echo "Newest ${ver} release: ${version}"

url="https://github.com/openshift/origin/releases/download/${version}/CHECKSUM"
curl -sSL "$url" \
  | grep 'client-tools.*linux-64bit.tar.gz$' \
  | while read -r shasum filename; do \
      archive="$(basename "$filename")"
      archive=${archive%.tar.gz}
      sed \
        -e "s/%%VERSION%%/${version}/" \
        -e "s/%%ARCHIVE%%/${archive}/" \
        -e "s/%%SHA256SUM%%/${shasum}/" \
        src/Dockerfile > "${ver}/Dockerfile"
    done
