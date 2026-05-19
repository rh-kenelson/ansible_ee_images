#!/usr/bin/env bash
# Generate files/ansible.cfg from HUB_HOST and HUB_TOKEN (gitignored).
# Used by CI and local builds before ansible-builder create.
set -euo pipefail

: "${HUB_HOST:?Set HUB_HOST (hub hostname or IP, no https://)}"
: "${HUB_TOKEN:?Set HUB_TOKEN (hub API token)}"

EE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "${EE_DIR}/files"
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
  > "${EE_DIR}/files/ansible.cfg"

