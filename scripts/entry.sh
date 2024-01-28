#!/bin/bash
set -e

USER="root"

# Setup local user
if [ "${BUILDER_UID:-0}" -ne 0 ] && [ "${BUILDER_GID:-0}" -ne 0 ]; then
  groupadd -g "${BUILDER_GID}" builder
  useradd -m -u "${BUILDER_UID}" -g "${BUILDER_GID}" -G sudo builder
  echo "builder ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
  # Make sure cache is accessible by builder
  # Make sure output is accessible by builder (if anonymous volume is used)
  mkdir -p /build || true
  chown "${BUILDER_UID}:${BUILDER_GID}" /build || true
  USER="builder"
fi

if CMD="$(command -v "$1")"; then
  shift
  sudo -H -u ${USER} "$CMD" "$@"
else
  echo "Command not found: $1"
  exit 1
fi
