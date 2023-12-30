FROM golang:1.21

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
  && apt-get install -y --no-install-recommends curl \
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install aqua
ARG AQUA_INSTALLER_VERSION="2.2.0"
ARG AQUA_VERSION="2.20.0"
RUN curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v${AQUA_INSTALLER_VERSION}/aqua-installer \
  | bash -s -- -v v${AQUA_VERSION}

COPY ../aqua-policy.yaml /app/aqua-policy.yaml
COPY ../aqua-registry.yaml /app/aqua-registry.yaml
COPY ../aqua.yaml /app/aqua.yaml

WORKDIR /app

ENV AQUA_GLOBAL_CONFIG=/app/aqua.yaml
ENV PATH="/root/.local/share/aquaproj-aqua/bin:$PATH"
ENV AQUA_POLICY_CONFIG=/app/aqua-policy.yaml
RUN aqua -c /app/aqua.yaml i

