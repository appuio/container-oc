FROM centos:7

ENV VERSION=v3.7.2 \
    COMMIT=282e43f \
    SHA256SUM=abc89f025524eb205e433622e59843b09d2304cc913534c4ed8af627da238624

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
