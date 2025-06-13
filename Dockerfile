FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including bash BEFORE any bash scripts are run
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq bash \
    && rm -rf /var/lib/apt/lists/*

# Download and install the SDK CLI using bash explicitly
RUN curl -s -o /tmp/install.sh https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh \
    && bash /tmp/install.sh \
    && rm /tmp/install.sh

# Set working directory
WORKDIR /sdk

# Copy helper script
COPY sdk-init.sh /sdk/sdk-init.sh
RUN chmod +x /sdk/sdk-init.sh

CMD ["/bin/bash"]
