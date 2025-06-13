#!/bin/bash

# Garmin Connect IQ SDK CLI Setup Script (for Linux/Docker)

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
connect-iq-sdk-manager agreement accept --acceptance-hash "$ACCEPTANCE_HASH"

echo ""
echo "🔐 Logging into Garmin developer account..."
read -p "Enter your Garmin username (email): " GARMIN_USERNAME
read -s -p "Enter your Garmin password: " GARMIN_PASSWORD
echo ""
export GARMIN_USERNAME
export GARMIN_PASSWORD

connect-iq-sdk-manager login

echo ""
echo "⬇️ Downloading SDK version $SDK_VERSION..."
connect-iq-sdk-manager sdk set "$SDK_VERSION"

echo ""
echo "📦 Current SDK path: $(connect-iq-sdk-manager sdk current-path)"

if [ -f "$MANIFEST_FILE" ]; then
    echo "📂 Downloading devices based on manifest: $MANIFEST_FILE"
    connect-iq-sdk-manager device download --manifest="$MANIFEST_FILE"
else
    echo "⚠️ Warning: '$MANIFEST_FILE' not found. Skipping device download."
    echo "📄 If you want to fetch devices later, run:"
    echo "    connect-iq-sdk-manager device download --manifest=your_manifest.xml"
fi

echo ""
echo "✅ SDK setup complete!"
