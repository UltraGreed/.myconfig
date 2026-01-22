#!/usr/bin/env bash
set -euo pipefail

dev=$(
  lsblk -rpo "NAME,TYPE,RM,MOUNTPOINT" \
  | awk '$2=="part" && $3==1 && $4=="" {print $1; exit}'
)

[ -n "${dev:-}" ] || exit 1

out=$(udisksctl mount -b "$dev")
mp=$(sed -n 's/.* at \(.*\)/\1/p' <<< "$out")

[ -n "$mp" ] || exit 1
printf '%s\n' "$mp"

