FROM docker.io/library/centos:7

ENV VERSION=v3.9.0 \
    HELM_VERSION=v2.12.2 \
    ARCHIVE=openshift-origin-client-tools-v3.9.0-191fece-linux-64bit \
    SHA256SUM=6ed2fb1579b14b4557e4450a807c97cd1b68a6c727cd1e12deedc5512907222e \
    HELM_SHA256SUM=edad6d5e594408b996b8d758a04948f89dab15fa6c6ea6daee3709f8c099df6d \
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
    yum install -y git gettext && \
    yum clean all -y && \
    ln -s /bin/oc /bin/kubectl && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
