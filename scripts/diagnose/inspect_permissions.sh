#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

POLICY_NAME="${1:-}"

if [[ -z "${POLICY_NAME}" ]]; then
    log_error "Usage: $0 <policy-name>"
    exit 1
fi

log_info "Inspecting IAM Policy: ${POLICY_NAME}"

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

DEFAULT_VERSION=$(
    aws iam get-policy \
        --policy-arn "${POLICY_ARN}" \
        --query 'Policy.DefaultVersionId' \
        --output text
)

aws iam get-policy-version \
    --policy-arn "${POLICY_ARN}" \
    --version-id "${DEFAULT_VERSION}" \
    --query 'PolicyVersion.Document' \
    --output json