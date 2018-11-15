FROM docker.io/library/centos:7

ENV VERSION=v3.7.2 \
    ARCHIVE=openshift-origin-client-tools-v3.7.2-282e43f-linux-64bit \
    SHA256SUM=abc89f025524eb205e433622e59843b09d2304cc913534c4ed8af627da238624 \
    OKD_REPO_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

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

WORKDIR /
ENTRYPOINT ["/bin/oc"]
CMD []
