ARG AZURECLI_VERSION=2.83.0-azurelinux3.0
ARG AWSCLI_VERSION=2.33.27
##############################################################################
FROM mcr.microsoft.com/azure-cli:${AZURECLI_VERSION} AS awscli-builder

ARG AWSCLI_VERSION

RUN tdnf install -y \
  curl \
  make \
  cmake \
  gcc \
  tar \
  gawk \
  && curl https://awscli.amazonaws.com/awscli-${AWSCLI_VERSION}.tar.gz | tar -xz \
  && cd awscli-${AWSCLI_VERSION} \
  && ./configure --prefix=/opt/aws-cli/ --with-download-deps \
  && make \
  && make install
##############################################################################
FROM scratch
COPY --from=awscli-builder /opt/aws-cli/ /opt/aws-cli/
