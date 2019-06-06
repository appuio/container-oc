FROM docker.io/library/centos:7@sha256:b5e66c4651870a1ad435cd75922fe2cb943c9e973a9673822d1414824a1d0475

ENV VERSION=v3.11.0 \
    HELM_VERSION=v2.14.1 \
    KUSTOMIZE_VERSION=v2.0.3 \
    ARCHIVE=openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit \
    SHA256SUM=4b0f07428ba854174c58d2e38287e5402964c9a9355f6c359d1242efd0990da3 \
    HELM_SHA256SUM=804f745e6884435ef1343f4de8940f9db64f935cd9a55ad3d9153d064b7f5896 \
    KUSTOMIZE_SHA256SUM=a04d79a013827c9ebb0abfe9d41cbcedf507a0310386c8d9a7efec7a36f9d7a3 \
    OKD_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    HELM_RELEASES_URL="https://storage.googleapis.com/kubernetes-helm" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

RUN set -x && \
    URL="${OKD_RELEASES_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM_URL="${HELM_RELEASES_URL}/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    KUSTOMIZE_URL="${KUSTOMIZE_RELEASES_URL}/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION:1}_linux_amd64" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM_URL" -o /tmp/helm.tgz && \
    curl -sSL "$KUSTOMIZE_URL" -o /tmp/kustomize && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${HELM_SHA256SUM}  /tmp/helm.tgz" > /tmp/HELM_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize" > /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    sha256sum -c /tmp/HELM_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    tar -xzvf /tmp/helm.tgz && \
    chmod 755 /tmp/kustomize && \
    mv -v "/tmp/${ARCHIVE}/oc" /bin/ && \
    mv -v "/tmp/linux-amd64/helm" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    rm -rf /tmp/* && \
    yum install -y git gettext && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
