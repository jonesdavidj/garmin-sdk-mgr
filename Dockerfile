FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including bash
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq bash \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /sdk

# Copy helper scripts into the container
COPY sdk-init.sh install-cli.sh /sdk/

# Ensure both scripts are executable at build time
RUN chmod +x /sdk/sdk-init.sh /sdk/install-cli.sh

# Default to bash shell
CMD ["/bin/bash"]
