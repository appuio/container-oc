FROM docker.io/library/centos:7@sha256:a36b9e68613d07eec4ef553da84d0012a5ca5ae4a830cf825bb68b929475c869

ENV VERSION=%%VERSION%% \
    HELM_VERSION=%%HELM_VERSION%% \
    KUSTOMIZE_VERSION=%%KUSTOMIZE_VERSION%% \
    KUBEVAL_VERSION=%%KUBEVAL_VERSION%% \
    ARCHIVE=%%ARCHIVE%% \
    SHA256SUM=%%SHA256SUM%% \
    HELM_SHA256SUM=%%HELM_SHA256SUM%% \
    KUSTOMIZE_SHA256SUM=%%KUSTOMIZE_SHA256SUM%% \
    KUBEVAL_SHA256SUM=%%KUBEVAL_SHA256SUM%% \
    SOPS_VERSION=%%SOPS_VERSION%% \
    SOPS_RELEASES_URL="https://github.com/mozilla/sops/releases/download" \
    OKD_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    HELM_RELEASES_URL="https://storage.googleapis.com/kubernetes-helm" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    KUBEVAL_RELEASES_URL="https://github.com/instrumenta/kubeval/releases/download" \
    JQ_URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

RUN set -x && \
    URL="${OKD_RELEASES_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM_URL="${HELM_RELEASES_URL}/helm-${HELM_VERSION}-linux-amd64.tar.gz" && \
    KUSTOMIZE_URL="${KUSTOMIZE_RELEASES_URL}/${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION:1}_linux_amd64" && \
    KUBEVAL_URL="${KUBEVAL_RELEASES_URL}/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" && \
    SOPS_URL="${SOPS_RELEASES_URL}/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM_URL" -o /tmp/helm.tgz && \
    curl -sSL "$KUSTOMIZE_URL" -o /tmp/kustomize && \
    curl -sSL "$KUBEVAL_URL" -o /tmp/kubeval.tgz && \
    curl -sSL "$JQ_URL" -o /tmp/jq && \
    curl -sSL "$SOPS_URL" -o /bin/sops && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${HELM_SHA256SUM}  /tmp/helm.tgz" > /tmp/HELM_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize" > /tmp/KUSTOMIZE_CHECKSUM && \
    echo "${KUBEVAL_SHA256SUM}  /tmp/kubeval.tgz" > /tmp/KUBEVAL_CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    sha256sum -c /tmp/HELM_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/KUBEVAL_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    tar -xzvf /tmp/helm.tgz && \
    tar -xzvf /tmp/kubeval.tgz && \
    chmod 755 /tmp/kustomize /tmp/jq /bin/sops && \
    mv -v "/tmp/${ARCHIVE}/oc" /bin/ && \
    mv -v "/tmp/linux-amd64/helm" /bin/ && \
    mv -v "/tmp/kubeval" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    mv -v "/tmp/jq" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    rm -rf /tmp/* && \
    yum install -y git gettext && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
