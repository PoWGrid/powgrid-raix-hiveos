# PowGrid Reticulum AI ($RAIX) HiveOS Integration

[![HiveOS](https://img.shields.io/badge/HiveOS-Custom%20Miner-blue.svg)](https://hiveon.com/)
[![Coin](https://img.shields.io/badge/Coin-RAIX-orange.svg)](https://raix.powgrid.xyz/)
[![Algorithm](https://img.shields.io/badge/Algorithm-RandomX-success.svg)]()

Official **HiveOS Custom Miner integration package** for mining **Reticulum AI ($RAIX)** on GPU mining rigs (NVIDIA & AMD) via the PowGrid community pool.

---

## Flight Sheet Configuration

To configure your rig in the HiveOS Web Dashboard:

1. Navigate to **Flight Sheets** and click **Add Flight Sheet**.
2. Set the basic flight sheet parameters:
   - **Coin**: `RAIX`
   - **Wallet**: Select your Reticulum AI wallet address (`ctx1...`) or `%WAL%`
   - **Pool**: `Configure in miner`
   - **Miner**: `Custom`
3. Click **Setup Miner Config** (Custom Miner window) and enter:

| Field | Value |
| :--- | :--- |
| **Miner name** | `powgrid-miner` |
| **Installation URL** | `https://raix.powgrid.xyz/downloads/powgrid-raix-gpu-miner-hiveos.tar.gz` |
| **Hash algorithm** | `RandomX` |
| **Wallet and worker template** | `%WAL%.%WORKER_NAME%` |
| **Pool server** | `https://raix.powgrid.xyz` |
| **Extra config arguments** | *(Optional, see below)* |

---

## Extra Configuration Arguments

You can pass extra CLI flags into the **Extra config arguments** field:

- **Specific GPUs only**: `--devices 0,1,2`
- **Force backend**: `--backend cuda` or `--backend opencl`
- **Custom thread concurrency**: `--threads 4096`

Example:
```bash
--backend cuda --devices 0,1,2
```

---

## Telemetry & Stats

This package includes native `h-stats.sh` integration:
- Live aggregate hashrate reported directly to the HiveOS dashboard.
- Live accepted/rejected share counters.
- Hardware temperature and fan speed monitoring for all active GPUs.

---

## Building the Package Manually

If you wish to build your own custom HiveOS tarball:

1. Copy your compiled `powgrid-raix-gpu-miner` Linux x64 binary into `powgrid-miner/`.
2. Run the packaging script:
   ```bash
   ./package.sh
   ```
3. Host the generated `powgrid-raix-gpu-miner-hiveos.tar.gz` archive on your HTTP/HTTPS server and put its URL in the HiveOS Flight Sheet.

---

## License

Dual-licensed under either:
- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE))
- MIT License ([LICENSE-MIT](LICENSE-MIT))

at your option.
