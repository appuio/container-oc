FROM docker.io/library/centos:7@sha256:c2f1d5a9c0a81350fa0ad7e1eee99e379d75fe53823d44b5469eb2eb6092c941

ENV VERSION=4.1 \
    HELM2_VERSION=v2.16.7 \
    HELM3_VERSION=v3.1.3 \
    KUSTOMIZE_VERSION=v3.5.4 \
    SEISO_VERSION=v0.5.1 \
    IMAGE_CLEANUP_VERSION=v0.3.0-rc.1 \
    KUBEVAL_VERSION=0.15.0 \
    ARCHIVE=linux/oc \
    SHA256SUM= \
    HELM2_SHA256SUM=4afe48da420e4c3adcccf8484f27991834e3a3838668103199f274f4fa6f2df2 \
    HELM3_SHA256SUM=7ca15cb5e3a76393eccd7389f2b3d20082b8c535b6689882613bfcc4a7d07c23 \
    KUSTOMIZE_SHA256SUM=5cdeb2af81090ad428e3a94b39779b3e477e2bc946be1fe28714d1ca28502f6a \
    SEISO_SHA256SUM=fbb0450210385d660d3b516129e059a8ea00f65c64b3f229e17557ba2465b161 \
    IMAGE_CLEANUP_SHA256SUM=14f64a616f17c49008a5e66c4078e6870f07a2a6be24d8ddd932396a22ee0607 \
    KUBEVAL_SHA256SUM=70bff2642a2886c0d9ebea452ffb81f333a956e26bbe0826fd7c6797e343e5aa \
    SOPS_VERSION=v3.5.0 \
    SOPS_RELEASES_URL="https://github.com/mozilla/sops/releases/download" \
    OKD_DOWNLOAD_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/clients/oc" \
    HELM_RELEASES_URL="https://get.helm.sh" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    SEISO_RELEASES_URL="https://github.com/appuio/seiso/releases/download" \
    KUBEVAL_RELEASES_URL="https://github.com/instrumenta/kubeval/releases/download" \
    JQ_URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

COPY opt/helm2-deprecation.sh /opt/
COPY image-cleanup.sh /bin/image-cleanup

RUN set -x && \
    URL="${OKD_DOWNLOAD_BASE_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM2_URL="${HELM_RELEASES_URL}/helm-${HELM2_VERSION}-linux-amd64.tar.gz" && \
    HELM3_URL="${HELM_RELEASES_URL}/helm-${HELM3_VERSION}-linux-amd64.tar.gz" && \
    KUSTOMIZE_URL="${KUSTOMIZE_RELEASES_URL}/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    SEISO_URL="${SEISO_RELEASES_URL}/${SEISO_VERSION}/seiso_linux_amd64" && \
    IMAGE_CLEANUP_URL="${SEISO_RELEASES_URL}/${IMAGE_CLEANUP_VERSION}/image-cleanup_linux_amd64" && \
    KUBEVAL_URL="${KUBEVAL_RELEASES_URL}/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" && \
    SOPS_URL="${SOPS_RELEASES_URL}/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM2_URL" -o /tmp/helm2.tgz && \
    curl -sSL "$HELM3_URL" -o /tmp/helm3.tgz && \
    curl -sSL "$KUSTOMIZE_URL" -o /tmp/kustomize.tgz && \
    curl -sSL "$SEISO_URL" -o /tmp/seiso && \
    curl -sSL "$IMAGE_CLEANUP_URL" -o /tmp/image-cleanup && \
    curl -sSL "$KUBEVAL_URL" -o /tmp/kubeval.tgz && \
    curl -sSL "$JQ_URL" -o /tmp/jq && \
    curl -sSL "$SOPS_URL" -o /bin/sops && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${HELM2_SHA256SUM}  /tmp/helm2.tgz" > /tmp/HELM2_CHECKSUM && \
    echo "${HELM3_SHA256SUM}  /tmp/helm3.tgz" > /tmp/HELM3_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize.tgz" > /tmp/KUSTOMIZE_CHECKSUM && \
    echo "${SEISO_SHA256SUM}  /tmp/seiso" > /tmp/SEISO_CHECKSUM && \
    echo "${IMAGE_CLEANUP_SHA256SUM}  /tmp/image-cleanup" > /tmp/IMAGE_CLEANUP_CHECKSUM && \
    echo "${KUBEVAL_SHA256SUM}  /tmp/kubeval.tgz" > /tmp/KUBEVAL_CHECKSUM && \
    [ ! -z "$SHA256SUM" ] && sha256sum -c /tmp/CHECKSUM || echo "oc sha not checked" && \
    sha256sum -c /tmp/HELM2_CHECKSUM && \
    sha256sum -c /tmp/HELM3_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/SEISO_CHECKSUM && \
    sha256sum -c /tmp/IMAGE_CLEANUP_CHECKSUM && \
    sha256sum -c /tmp/KUBEVAL_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    tar -xzvf /tmp/helm2.tgz && \
    mv -v "/tmp/linux-amd64/helm" /bin/helm2 && \
    rm -rf -v "/tmp/linux-amd64" && \
    tar -xzvf /tmp/helm3.tgz && \
    mv -v "/tmp/linux-amd64/helm" /bin/helm3 && \
    tar -xzvf /tmp/kustomize.tgz && \
    tar -xzvf /tmp/kubeval.tgz && \
    chmod 755 /tmp/kustomize /tmp/seiso /tmp/jq /bin/sops /tmp/image-cleanup && \
    mv -v "/tmp/oc" /bin/ && \
    mv -v "/tmp/kubeval" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    mv -v "/tmp/seiso" /bin/ && \
    mv -v "/tmp/image-cleanup" /opt/ && \
    mv -v "/tmp/jq" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    ln -s /opt/helm2-deprecation.sh /bin/helm && \
    rm -rf /tmp/* && \
    yum install -y git gettext && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH} && \
    helm2 init --client-only
