FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including bash (missing!)
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq bash \
    && rm -rf /var/lib/apt/lists/*

# Install the SDK Manager CLI using bash
RUN curl -s https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh | bash

WORKDIR /sdk

COPY sdk-init.sh /sdk/sdk-init.sh
RUN chmod +x /sdk/sdk-init.sh

CMD ["/bin/bash"]
