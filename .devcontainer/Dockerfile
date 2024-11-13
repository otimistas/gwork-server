ARG VARIANT="1.21-bookworm"
FROM mcr.microsoft.com/devcontainers/go:1-${VARIANT}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

USER vscode

# Install aqua
ARG AQUA_INSTALLER_VERSION="2.2.0"
ARG AQUA_VERSION="2.20.0"
ENV AQUA_ROOT_DIR="/home/vscode/.aqua"
ENV PATH="/home/vscode/.aqua/bin:${PATH}"
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v${AQUA_INSTALLER_VERSION}/aqua-installer \
  | bash -s -- -v v${AQUA_VERSION}

# hadolint ignore=SC1091
RUN umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install "${NODE_VERSION}" 2>&1
