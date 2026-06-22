#!/usr/bin/env bash
# Write a shared hub ansible.cfg used by all EEs that reference ../files/ansible.cfg.
# CI sets HUB_HOST and HUB_TOKEN from secrets; local builds export them first.
set -euo pipefail

: "${HUB_HOST:?Set HUB_HOST (hub hostname or IP, no https://)}"
: "${HUB_TOKEN:?Set HUB_TOKEN (hub API token)}"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "${REPO_ROOT}/files"
printf '%s\n' \
  '[galaxy]' \
  'server_list = my_hub, gald' \
  '' \
  '[galaxy_server.my_hub]' \
  "url = https://${HUB_HOST}/api/galaxy/content/rh-certified/" \
  "token = ${HUB_TOKEN}" \
  'validate_certs = False' \
  '' \
  '[galaxy_server.gald]' \
  "url = https://${HUB_HOST}/api/galaxy/content/validated/" \
  "token = ${HUB_TOKEN}" \
  'validate_certs = False' \
  > "${REPO_ROOT}/files/ansible.cfg"

echo "Wrote ${REPO_ROOT}/files/ansible.cfg"
