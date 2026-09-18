#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

echo "=== Packaging PowGrid Reticulum AI (\$RAIX) HiveOS Custom Miner ==="

OUTPUT_FILE="powgrid-raix-gpu-miner-hiveos.tar.gz"

# Verify required files exist
for f in h-manifest.conf h-config.sh h-run.sh h-stats.sh; do
    if [ ! -f "powgrid-miner/$f" ]; then
        echo "[ERROR] Missing required file: powgrid-miner/$f"
        exit 1
    fi
done

chmod +x powgrid-miner/*.sh

tar -czf "$OUTPUT_FILE" powgrid-miner

echo "✅ Package created successfully: $OUTPUT_FILE"
ls -lh "$OUTPUT_FILE"
