FROM centos:7

ENV VERSION=v3.6.1 \
    COMMIT=008f2d5 \
    SHA256SUM=922afb7a5642040ea7a6b780cd68eb1d15533b6376b503351a4c38a452338d11

RUN set -x && \
    ARCHIVE="openshift-origin-client-tools-${VERSION}-${COMMIT}-linux-64bit" && \
    URL="https://github.com/openshift/origin/releases/download/${VERSION}/${ARCHIVE}.tar.gz" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    tar -xzvf "/tmp/oc.tgz" && \
    cp "/tmp/${ARCHIVE}/oc" /bin/oc && \
    rm -rf /tmp/*
