FROM registry.access.redhat.com/ubi9-minimal:9.8-1784596070

ENV VERSION=latest-4.13 \
    HELM3_VERSION=v4.2.0 \
    KUBEVAL_VERSION=v0.16.1 \
    KUSTOMIZE_VERSION=v5.8.1 \
    SOPS_VERSION=v3.13.1 \
    YQ_VERSION=v4.53.2 \
    ARCHIVE=openshift-client-linux \
    HELM3_SHA256SUM=97dbeb971be4ac4b27e3839976d9564c0fb35c6f3b1da89dd1e292d236af4096 \
    KUBEVAL_SHA256SUM=2d6f9bda1423b93787fa05d9e8dfce2fc1190fefbcd9d0936b9635f3f78ba790 \
    KUSTOMIZE_SHA256SUM=029a7f0f4e1932c52a0476cf02a0fd855c0bb85694b82c338fc648dcb53a819d \
    SHA256SUM= \
    YQ_SHA256SUM=d56bf5c6819e8e696340c312bd70f849dc1678a7cda9c2ad63eebd906371d56b \
    HELM_RELEASES_URL="https://get.helm.sh" \
    KUBEVAL_RELEASES_URL="https://github.com/instrumenta/kubeval/releases/download" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    OKD_DOWNLOAD_BASE_URL="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp" \
    SOPS_RELEASES_URL="https://github.com/getsops/sops/releases/download" \
    YQ_RELEASES_URL="https://github.com/mikefarah/yq/releases/download" \
    JQ_URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
    OC_PLUGINS_REPO="https://github.com/appuio/oc-plugins" \
    KUBECTL_PLUGINS_PATH="/opt/kube/plugins"

RUN set -x && \
    URL="${OKD_DOWNLOAD_BASE_URL}/${VERSION}/${ARCHIVE}.tar.gz" && \
    HELM3_URL="${HELM_RELEASES_URL}/helm-${HELM3_VERSION}-linux-amd64.tar.gz" && \
    KUBEVAL_URL="${KUBEVAL_RELEASES_URL}/${KUBEVAL_VERSION}/kubeval-linux-amd64.tar.gz" && \
    KUSTOMIZE_URL="${KUSTOMIZE_RELEASES_URL}/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" && \
    SOPS_URL="${SOPS_RELEASES_URL}/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64" && \
    YQ_URL="${YQ_RELEASES_URL}/${YQ_VERSION}/yq_linux_amd64" && \
    microdnf install -y tar gzip git python3 diffutils findutils && \
    microdnf update tzdata -y && \
    microdnf reinstall -y tzdata && \
    cd /tmp && \
    curl -sSL "$URL" -o /tmp/oc.tgz && \
    curl -sSL "$HELM3_URL" -o /tmp/helm3.tgz && \
    curl -sSL "$JQ_URL" -o /bin/jq && \
    curl -sSL "$KUBEVAL_URL" -o /tmp/kubeval.tgz && \
    curl -sSL "$KUSTOMIZE_URL" -o /tmp/kustomize.tgz && \
    curl -sSL "$SOPS_URL" -o /bin/sops && \
    curl -sSL "$YQ_URL" -o /bin/yq && \
    echo "${HELM3_SHA256SUM}  /tmp/helm3.tgz" > /tmp/HELM3_CHECKSUM && \
    echo "${KUBEVAL_SHA256SUM}  /tmp/kubeval.tgz" > /tmp/KUBEVAL_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize.tgz" > /tmp/KUSTOMIZE_CHECKSUM && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${YQ_SHA256SUM}  /bin/yq" > /tmp/YQ_CHECKSUM && \
    [ ! -z "$SHA256SUM" ] && sha256sum -c /tmp/CHECKSUM || echo "oc sha not checked" && \
    sha256sum -c /tmp/HELM3_CHECKSUM && \
    sha256sum -c /tmp/KUBEVAL_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/YQ_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    rm -rf -v "/tmp/linux-amd64" && \
    tar -xzvf /tmp/helm3.tgz && \
    mv -v "/tmp/linux-amd64/helm" /bin/helm3 && \
    tar -xzvf /tmp/kustomize.tgz && \
    tar -xzvf /tmp/kubeval.tgz && \
    chmod 755 /tmp/kustomize /bin/jq /bin/sops /bin/yq && \
    mv -v "/tmp/oc" /bin/ && \
    mv -v "/tmp/kubeval" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    ln -s /bin/helm3 /bin/helm && \
    rm -rf /tmp/* && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
