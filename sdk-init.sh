#!/bin/bash

set -e

SDK_VERSION="8.1.1"
MANIFEST_FILE="manifest.xml"

echo "🔧 Checking if SDK Manager CLI is installed..."
if ! command -v connect-iq-sdk-manager &> /dev/null; then
    echo "❌ 'connect-iq-sdk-manager' is not installed. Please install it first."
    echo "💡 Run: curl -s https://raw.githubusercontent.com/lindell/connect-iq-sdk-manager-cli/master/install.sh | bash"
    exit 1
fi

echo ""
echo "📜 Viewing Garmin SDK license..."
connect-iq-sdk-manager agreement view

read -p "Paste the acceptance hash from above: " ACCEPTANCE_HASH
connect-iq-sdk-manager agreement accept --agreement-hash "$ACCEPTANCE_HASH"

# Use env vars or prompt fallback
if [ -z "$GARMIN_USERNAME" ]; then
  read -p "Enter your Garmin username (email): " GARMIN_USERNAME
fi

if [ -z "$GARMIN_PASSWORD" ]; then
  read -s -p "Enter your Garmin password: " GARMIN_PASSWORD
  echo ""
fi

export GARMIN_USERNAME
export GARMIN_PASSWORD

echo ""
echo "🔐 Logging into Garmin developer account..."
connect-iq-sdk-manager login

echo ""
echo "⬇️ Downloading SDK version $SDK_VERSION..."
connect-iq-sdk-manager sdk set "$SDK_VERSION"

echo ""
echo "📂 Checking for manifest: $MANIFEST_FILE"
if [ -f "$MANIFEST_FILE" ]; then
    echo "📦 Downloading devices for manifest..."
    connect-iq-sdk-manager device download --manifest="$MANIFEST_FILE"
else
    echo "⚠️ '$MANIFEST_FILE' not found — skipping device download."
fi

echo ""
echo "✅ SDK setup complete!"
