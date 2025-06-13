# Dockerfile.sdkmgr
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq \
    && rm -rf /var/lib/apt/lists/*

# Install the SDK Manager CLI
RUN curl -s https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh | bash

# Set working directory
WORKDIR /sdk

# Copy the helper script into the container
COPY sdk-init.sh /sdk/sdk-init.sh

# Make the script executable
RUN chmod +x /sdk/sdk-init.sh

CMD ["/bin/bash"]
