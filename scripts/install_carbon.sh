#!/bin/bash
CARBON_URL="https://github.com/CarbonCommunity/Carbon.Core/releases/download/${CARBON_VERSION}_build/Carbon.Linux.$( [ $CARBON_VERSION == "production" ] && echo "Release" || echo "Debug" ).tar.gz"

echo "Pulling latest Carbon $CARBON_VERSION build from $CARBON_URL"

curl -L $CARBON_URL | \
mkdir -p /app/carbon && tar -xz -C /app/carbon/

echo "Move Carbon files to Server Directory"
cp -prv /app/carbon/* /app/rust/

echo "Clear Carbon Download"
rm -rf /app/carbon