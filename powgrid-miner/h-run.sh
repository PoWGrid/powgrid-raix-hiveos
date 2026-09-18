#!/usr/bin/env bash

cd `dirname $0`
. h-manifest.conf

[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo "No config file specified in manifest" && exit 1
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo "Config file $CUSTOM_CONFIG_FILENAME not found" && exit 1

. $CUSTOM_CONFIG_FILENAME

mkdir -p /var/log/miner/$CUSTOM_NAME

ARGS="--pool ${POOL_URL} --address ${WALLET} --worker ${WORKER} --hiveos"

if [[ ! -z "$USER_CONFIG" ]]; then
    ARGS="$ARGS $USER_CONFIG"
fi

echo "=========================================================="
echo " Starting PowGrid Reticulum AI (\$RAIX) Miner for HiveOS v${CUSTOM_VERSION}"
echo " Args: $ARGS"
echo "=========================================================="

BIN="./powgrid-raix-gpu-miner"
if [[ ! -f "$BIN" ]]; then
    BIN="./powgrid-ctx-rust-gpu-miner"
fi

$BIN $ARGS 2>&1 | tee ${CUSTOM_LOG_BASENAME}.log
