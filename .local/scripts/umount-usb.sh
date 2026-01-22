#!/usr/bin/env bash
set -euo pipefail

mount_dir=$1

best_dev=""
best_mp=""

# NAME TYPE RM MOUNTPOINT
while IFS=' ' read -r name type rm mp; do
  [ "$type" = "part" ] || continue
  [ "$rm" = "1" ] || continue
  [ -n "$mp" ] || continue

  mp=${mp/'\x20'/' '}

  if [[ "$mount_dir" = "$mp"* ]]; then
    best_dev="$name"
    best_mp="$mp"
  fi
done < <(lsblk -rpo "NAME,TYPE,RM,MOUNTPOINT")

if [ -z "$best_dev" ]; then
  echo "No matching mounted removable device for $mount_dir" >&2
  exit 1
fi

udisksctl unmount -b "$best_dev"
