#!/usr/bin/env bash

# HiveOS Custom Miner Configuration Generator
. `dirname $0`/h-manifest.conf

[[ -z $CUSTOM_TEMPLATE ]] && echo "No wallet address specified" && exit 1

POOL_URL="${CUSTOM_URL:-https://raix.powgrid.xyz}"
if [[ ! $POOL_URL =~ ^http ]]; then
    POOL_URL="https://${POOL_URL}"
fi

WALLET="$CUSTOM_TEMPLATE"
WORKER="${CUSTOM_WORKER:-%WORKER_NAME%}"

mkdir -p $(dirname "$CUSTOM_CONFIG_FILENAME")

cat <<EOF > "$CUSTOM_CONFIG_FILENAME"
POOL_URL="${POOL_URL}"
WALLET="${WALLET}"
WORKER="${WORKER}"
USER_CONFIG="${CUSTOM_USER_CONFIG}"
EOF

echo "PowGrid HiveOS config generated: $CUSTOM_CONFIG_FILENAME"
