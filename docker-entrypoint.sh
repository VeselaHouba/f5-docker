#!/usr/bin/env bash
set -e
if [ -n "${ANSIBLE_VAULT_PASS+x}" ]; then
  echo "${ANSIBLE_VAULT_PASS}" > .vault_pass.txt
fi

exec "$@"
