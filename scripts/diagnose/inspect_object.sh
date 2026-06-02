#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

BUCKET="${1:-}"
OBJECT="${2:-}"

if [[ -z "${BUCKET}" || -z "${OBJECT}" ]]; then
    log_error "Usage: $0 <BUCKET> <OBJECT>"
    exit 1
fi

log_info "Inspecting object: s3://${BUCKET}/${OBJECT}"

aws s3api head-object \
    --bucket "$BUCKET" \
    --key "$OBJECT" \
    >/dev/null

log_info "Object exists"