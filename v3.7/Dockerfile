FROM centos:7

ENV VERSION=v3.7.2 \
    ARCHIVE=openshift-origin-client-tools-v3.7.2-282e43f-linux-64bit \
    SHA256SUM=abc89f025524eb205e433622e59843b09d2304cc913534c4ed8af627da238624

RUN set -x && \
    URL="https://github.com/openshift/origin/releases/download/${VERSION}/${ARCHIVE}.tar.gz" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    tar -xzvf "/tmp/oc.tgz" && \
    cp "/tmp/${ARCHIVE}/oc" /bin/oc && \
    rm -rf /tmp/* && \
    yum install -y git && \
    yum clean all -y
