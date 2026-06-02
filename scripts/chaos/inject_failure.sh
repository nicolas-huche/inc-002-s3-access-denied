#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

POLICY_NAME="${1:-}"

if [[ -z "${POLICY_NAME}" ]]; then
    log_error "Usage: $0 <policy-name>"
    exit 1
fi

POLICY_ARN=$(
    aws iam list-policies \
        --scope Local \
        --query "Policies[?PolicyName=='${POLICY_NAME}'].Arn" \
        --output text
)

if [[ -z "${POLICY_ARN}" || "${POLICY_ARN}" == "None" ]]; then
    log_error "IAM Policy not found: ${POLICY_NAME}"
    exit 1
fi

log_warn "Replacing IAM policy document with failure policy"

aws iam create-policy-version \
    --policy-arn "${POLICY_ARN}" \
    --policy-document file://architecture/policies/failure-policy.json \
    --set-as-default

log_info "Failure injection completed"