FROM centos:7

ENV VERSION=v3.7.1 \
    COMMIT=ab0f056 \
    SHA256SUM=56e9dbff7e5e4ade1e92cc10ff1bd1ae2789ec400be0d8a5b2177fd6c465af21

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
