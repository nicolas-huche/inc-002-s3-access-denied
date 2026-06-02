#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

ROLE_NAME="${1:-}"

if [[ -z "${ROLE_NAME}" ]]; then
    log_error "Usage: $0 <role-name>"
    exit 1
fi

log_info "Inspecting IAM Policy attachments"

POLICIES=$(
    aws iam list-attached-role-policies \
        --role-name "${ROLE_NAME}" \
        --query 'AttachedPolicies[*].[PolicyName,PolicyArn]' \
        --output table
)

if [[ -z "${POLICIES}" || "${POLICIES}" == "None" ]]; then
    log_error "No IAM Policy attached"
    exit 1
fi

echo "${POLICIES}"
