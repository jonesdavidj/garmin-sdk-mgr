FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies including bash
RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq bash \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /sdk

COPY sdk-init.sh install-cli.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/sd*.sh

CMD ["/bin/bash"]