FROM docker.io/library/centos:7@sha256:b5e66c4651870a1ad435cd75922fe2cb943c9e973a9673822d1414824a1d0475

ENV VERSION=%%VERSION%% \
    HELM_VERSION=%%HELM_VERSION%% \
    KUSTOMIZE_VERSION=%%KUSTOMIZE_VERSION%% \
    ARCHIVE=%%ARCHIVE%% \
    SHA256SUM=%%SHA256SUM%% \
    HELM_SHA256SUM=%%HELM_SHA256SUM%% \
    KUSTOMIZE_SHA256SUM=%%KUSTOMIZE_SHA256SUM%% \
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
