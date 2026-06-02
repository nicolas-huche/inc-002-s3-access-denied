#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

BUCKET="${1:-}"

if [[ -z "${BUCKET}" ]]; then
    log_error "Usage: $0 <bucket>"
    exit 1
fi

log_info "Inspecting Bucket Policy: ${BUCKET}"

POLICY=$(
    aws s3api get-bucket-policy \
        --bucket "${BUCKET}" \
        --query 'Policy' \
        --output text 2>/dev/null || true
)

if [[ -z "${POLICY}" || "${POLICY}" == "None" ]]; then
    log_info "Bucket Policy is empty"
    exit 0
fi

echo "${POLICY}" | python3 -m json.tool