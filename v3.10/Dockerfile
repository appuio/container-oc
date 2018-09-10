FROM centos:7

ENV VERSION=v3.10.0 \
    ARCHIVE=openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit \
    SHA256SUM=0f54235127884309d19b23e8e64e347f783efd6b5a94b49bfc4d0bf472efb5b8

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
