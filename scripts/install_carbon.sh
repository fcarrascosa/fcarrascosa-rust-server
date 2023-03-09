#!/bin/bash
CARBON_URL=https://github.com/CarbonCommunity/Carbon.Core/releases/download/${CARBON_VERSION}_build/Carbon.Linux.${CARBON_VERSION == "production" ? "Release": "Debug"}.tar.gz"

echo "Pulling latest Carbon $CARBON_VERSION build from $CARBON_URL"

curl -L "$CARBON_URL" | \
tar -xz -C /app/rust/