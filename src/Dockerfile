FROM centos:7

ENV VERSION=%%VERSION%% \
    COMMIT=%%COMMIT%% \
    SHA256SUM=%%SHA256SUM%%

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
