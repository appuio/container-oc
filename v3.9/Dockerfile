FROM docker.io/library/centos:7@sha256:a36b9e68613d07eec4ef553da84d0012a5ca5ae4a830cf825bb68b929475c869

ENV VERSION=v3.9.0 \
    HELM_VERSION=v2.14.3 \
    KUSTOMIZE_VERSION=v3.1.0 \
    ARCHIVE=openshift-origin-client-tools-v3.9.0-191fece-linux-64bit \
    SHA256SUM=6ed2fb1579b14b4557e4450a807c97cd1b68a6c727cd1e12deedc5512907222e \
    HELM_SHA256SUM=38614a665859c0f01c9c1d84fa9a5027364f936814d1e47839b05327e400bf55 \
    KUSTOMIZE_SHA256SUM=73acc575cf4e035a91da63ecffcabe58f9572562b772c1eb7ed863991950afe8 \
    OKD_RELEASES_URL="https://github.com/openshift/origin/releases/download" \
    HELM_RELEASES_URL="https://storage.googleapis.com/kubernetes-helm" \
    KUSTOMIZE_RELEASES_URL="https://github.com/kubernetes-sigs/kustomize/releases/download" \
    JQ_URL="https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" \
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
    curl -sSL "$JQ_URL" -o /tmp/jq && \
    echo "${SHA256SUM}  /tmp/oc.tgz" > /tmp/CHECKSUM && \
    echo "${HELM_SHA256SUM}  /tmp/helm.tgz" > /tmp/HELM_CHECKSUM && \
    echo "${KUSTOMIZE_SHA256SUM}  /tmp/kustomize" > /tmp/KUSTOMIZE_CHECKSUM && \
    sha256sum -c /tmp/CHECKSUM && \
    sha256sum -c /tmp/HELM_CHECKSUM && \
    sha256sum -c /tmp/KUSTOMIZE_CHECKSUM && \
    tar -xzvf /tmp/oc.tgz && \
    tar -xzvf /tmp/helm.tgz && \
    chmod 755 /tmp/kustomize /tmp/jq && \
    mv -v "/tmp/${ARCHIVE}/oc" /bin/ && \
    mv -v "/tmp/linux-amd64/helm" /bin/ && \
    mv -v "/tmp/kustomize" /bin/ && \
    mv -v "/tmp/jq" /bin/ && \
    ln -s /bin/oc /bin/kubectl && \
    rm -rf /tmp/* && \
    yum install -y git gettext && \
    yum clean all -y && \
    git clone --depth=1 ${OC_PLUGINS_REPO} ${KUBECTL_PLUGINS_PATH}
