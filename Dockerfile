FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl unzip git ca-certificates jq \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh | bash

WORKDIR /sdk

COPY sdk-init.sh /sdk/sdk-init.sh
RUN chmod +x /sdk/sdk-init.sh

CMD ["/bin/bash"]
