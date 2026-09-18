#!/usr/bin/env bash

cd `dirname $0`
. h-manifest.conf

STATS_FILE="/tmp/powgrid_miner_stats.json"

if [[ ! -f $STATS_FILE ]]; then
    stats="null"
    khs=0
    return 0 2>/dev/null || exit 0
fi

eval $(python3 -c "
import json
try:
    with open('$STATS_FILE') as f:
        d = json.load(f)
    uptime = d.get('uptime', 0)
    hs = d.get('hashrate_avg', 0)
    acc = d.get('accepted', 0)
    rej = d.get('rejected', 0)
    print(f'UPTIME={uptime}; HS={hs}; ACC={acc}; REJ={rej};')
except:
    print('UPTIME=0; HS=0; ACC=0; REJ=0;')
")

khs=$(python3 -c "print(round(float('$HS') / 1000.0, 2))" 2>/dev/null || echo 0)

# Detect number of GPUs on this rig
gpu_count=$(gpu-detect NVIDIA AMD 2>/dev/null | wc -l)
[[ -z $gpu_count || $gpu_count -eq 0 ]] && gpu_count=1

stats=$(python3 -c "
import json
hs_val = float('$HS')
gpu_cnt = int('$gpu_count')
per_gpu = round(hs_val / max(1, gpu_cnt), 2)
hs_arr = [per_gpu] * gpu_cnt
out = {
    'hs': hs_arr,
    'hs_units': 'hs',
    'uptime': int('$UPTIME'),
    'ar': [int('$ACC'), int('$REJ')],
    'algo': 'randomx'
}
print(json.dumps(out))
")
