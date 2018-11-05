FROM centos:7

ENV VERSION=v3.6.1 \
    ARCHIVE=openshift-origin-client-tools-v3.6.1-008f2d5-linux-64bit \
    SHA256SUM=922afb7a5642040ea7a6b780cd68eb1d15533b6376b503351a4c38a452338d11 \
    OKD_REPO_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="~/.kube/plugins"

RUN set -x && \
    URL="${OKD_REPO_RELEASES_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    tar -xzvf "/tmp/oc.tgz" && \
    mv -v "/tmp/${ARCHIVE}/oc" /bin/oc && \
    rm -rf /tmp/* && \
    yum install -y git && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
