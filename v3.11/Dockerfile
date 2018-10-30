FROM centos:7

ENV VERSION=v3.11.0 \
    ARCHIVE=openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit \
    SHA256SUM=4b0f07428ba854174c58d2e38287e5402964c9a9355f6c359d1242efd0990da3

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
