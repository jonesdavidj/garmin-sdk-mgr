FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# First, install bash and other deps
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq bash \
    && rm -rf /var/lib/apt/lists/*

# Then separately run the bash script using bash (bash is now definitely available)
RUN curl -s -o /tmp/install.sh https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh
RUN bash /tmp/install.sh && rm /tmp/install.sh

# Set working directory
WORKDIR /sdk

# Copy the init script
COPY sdk-init.sh /sdk/sdk-init.sh
RUN chmod +x /sdk/sdk-init.sh

CMD ["/bin/bash"]
