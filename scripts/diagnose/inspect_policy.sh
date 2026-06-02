#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

ROLE_NAME="${1:-}"

if [[ -z "${ROLE_NAME}" ]]; then
    log_error "Usage: $0 <role-name>"
    exit 1
fi

log_info "Inspecting IAM Policy attachment"

POLICIES=$(
    aws iam list-attached-role-policies \
        --role-name "${ROLE_NAME}" \
        --query 'AttachedPolicies[].PolicyName' \
        --output text
)

if [[ -z "${POLICIES}" || "${POLICIES}" == "None" ]]; then
    log_error "No IAM Policy attached"
    exit 1
fi

while IFS= read -r POLICY; do
    [[ -n "${POLICY}" ]] && log_info "IAM Policy attached: ${POLICY}"
done < <(printf '%s\n' "${POLICIES}" | tr '\t' '\n')