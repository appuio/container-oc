FROM centos:7

ENV VERSION=v3.9.0 \
    ARCHIVE=openshift-origin-client-tools-v3.9.0-191fece-linux-64bit \
    SHA256SUM=6ed2fb1579b14b4557e4450a807c97cd1b68a6c727cd1e12deedc5512907222e

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
