FROM centos:7

ENV VERSION=v3.11.0 \
    ARCHIVE=openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit \
    SHA256SUM=4b0f07428ba854174c58d2e38287e5402964c9a9355f6c359d1242efd0990da3 \
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
