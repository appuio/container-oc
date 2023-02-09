FROM docker.io/library/centos:7@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4

ENV VERSION=latest-4.12 \
    HELM3_VERSION=v3.11.1 \
    KUBEVAL_VERSION=v0.16.1 \
    KUSTOMIZE_VERSION=v5.0.0 \
    SEISO_VERSION=v1.0.0 \
    SOPS_VERSION=v3.7.3 \
    YQ_VERSION=v4.30.8 \
    ARCHIVE=openshift-client-linux \
    HELM3_SHA256SUM=0b1be96b66fab4770526f136f5f1a385a47c41923d33aab0dcb500e0f6c1bf7c \
    KUBEVAL_SHA256SUM=2d6f9bda1423b93787fa05d9e8dfce2fc1190fefbcd9d0936b9635f3f78ba790 \
    KUSTOMIZE_SHA256SUM=2e8c28a80ce213528251f489db8d2dcbea7c63b986c8f7595a39fc76ff871cd7 \
    SEISO_SHA256SUM=40484059c23993b4e8d6b0add3debebb31ed1155b49a5ebdae987698b3176202 \
    SHA256SUM= \
    YQ_SHA256SUM=6c911103e0dcc54e2ba07e767d2d62bcfc77452b39ebaee45b1c46f062f4fd26 \
    HELM_RELEASES_URL="https://get.helm.sh" \
    KUBEVAL_RELEASES_URL="https://github.com/instrumenta/kubeval/releases/download" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    OKD_DOWNLOAD_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp" \
    SEISO_RELEASES_URL="https://github.com/appuio/seiso/releases/download" \
    SOPS_RELEASES_URL="https://github.com/mozilla/sops/releases/download" \
    YQ_RELEASES_URL="https://github.com/mikefarah/yq/releases/download" \
    JQ_URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

RUN set -x && \
    URL="${OKD_DOWNLOAD_BASE_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM3_URL="${HELM_RELEASES_URL}/helm-${HELM3_VERSION}-linux-amd64.tar.gz" && \
    KUBEVAL_URL="${KUBEVAL_RELEASES_URL}/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" && \
    KUSTOMIZE_URL="${KUSTOMIZE_RELEASES_URL}/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    SEISO_URL="${SEISO_RELEASES_URL}/${SEISO_VERSION}/seiso_linux_amd64" && \
    SOPS_URL="${SOPS_RELEASES_URL}/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux" && \
    YQ_URL="${YQ_RELEASES_URL}/${YQ_VERSION}/yq_linux_amd64" && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM3_URL" -o /tmp/helm3.tgz && \
    curl -sSL "$JQ_URL" -o /bin/jq && \
    curl -sSL "$KUBEVAL_URL" -o /tmp/kubeval.tgz && \
    curl -sSL "$KUSTOMIZE_URL" -o /tmp/kustomize.tgz && \
    curl -sSL "$SEISO_URL" -o /bin/seiso && \
    curl -sSL "$SOPS_URL" -o /bin/sops && \
    curl -sSL "$YQ_URL" -o /bin/yq && \
    echo "${HELM3_SHA256SUM}  /tmp/helm3.tgz" > /tmp/HELM3_CHECKSUM && \
    echo "${KUBEVAL_SHA256SUM}  /tmp/kubeval.tgz" > /tmp/KUBEVAL_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize.tgz" > /tmp/KUSTOMIZE_CHECKSUM && \
    echo "${SEISO_SHA256SUM}  /bin/seiso" > /tmp/SEISO_CHECKSUM && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${YQ_SHA256SUM}  /bin/yq" > /tmp/YQ_CHECKSUM && \
    [ ! -z "$SHA256SUM" ] && sha256sum -c /tmp/CHECKSUM || echo "oc sha not checked" && \
    sha256sum -c /tmp/HELM3_CHECKSUM && \
    sha256sum -c /tmp/KUBEVAL_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/SEISO_CHECKSUM && \
    sha256sum -c /tmp/YQ_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    rm -rf -v "/tmp/linux-amd64" && \
    tar -xzvf /tmp/helm3.tgz && \
    mv -v "/tmp/linux-amd64/helm" /bin/helm3 && \
    tar -xzvf /tmp/kustomize.tgz && \
    tar -xzvf /tmp/kubeval.tgz && \
    chmod 755 /tmp/kustomize /bin/seiso /bin/jq /bin/sops /bin/yq && \
    mv -v "/tmp/oc" /bin/ && \
    mv -v "/tmp/kubeval" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    ln -s /bin/helm3 /bin/helm && \
    rm -rf /tmp/* && \
    yum install -y epel-release git gettext && \
    yum install -y moreutils && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
