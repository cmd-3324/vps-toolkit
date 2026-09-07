#!/usr/bin/env bash
set -euo pipefail

domains=(google.com bing.com)

netman() {
  local ok=0 fail=0
  for d in "${domains[@]}"; do
    if ping -c 3 -W 3 "$d" &>/dev/null || curl -sSf --max-time 3 -o /dev/null "https://$d"; then
      echo "[OK]   $d"
      ((ok++))
    else
      echo "[FAIL] $d"
      ((fail++))
    fi
  done
  (( fail == 0 )) && echo "Network: UP" || echo "Network: DEGRADED ($fail/${#domains[@]} failed)"
}

netman
