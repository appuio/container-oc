FROM docker.io/library/centos:7

ENV VERSION=v3.10.0 \
    HELM_VERSION=v2.12.1 \
    ARCHIVE=openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit \
    SHA256SUM=0f54235127884309d19b23e8e64e347f783efd6b5a94b49bfc4d0bf472efb5b8 \
    HELM_SHA256SUM=891004bec55431b39515e2cedc4f4a06e93782aa03a4904f2bd742b168160451 \
    OKD_REPO_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    HELM_RELEASES_URL="https://storage.googleapis.com/kubernetes-helm" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

RUN set -x && \
    URL="${OKD_REPO_RELEASES_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM_URL="${HELM_RELEASES_URL}/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM_URL" -o /tmp/helm.tgz && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${HELM_SHA256SUM}  /tmp/helm.tgz" > /tmp/HELM_CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    sha256sum -c /tmp/HELM_CHECKSUM && \
    tar -xzvf "/tmp/oc.tgz" && \
    tar -xzvf "/tmp/helm.tgz" && \
    mv -v "/tmp/${ARCHIVE}/oc" /bin/oc && \
    mv -v "/tmp/linux-amd64/helm" /bin/helm && \
    rm -rf /tmp/* && \
    yum install -y git && \
    yum clean all -y && \
    ln -s /bin/oc /bin/kubectl && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
