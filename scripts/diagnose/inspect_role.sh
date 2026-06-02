#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

log_info "Inspecting IAM Role attachment"

ROLE_NAME=$(
    aws ec2 describe-instances \
        --filters Name=instance-state-name,Values=running \
        --query 'Reservations[].Instances[].IamInstanceProfile.Arn' \
        --output text |
    awk -F'/' '{print $NF}'
)

if [[ -z "${ROLE_NAME}" || "${ROLE_NAME}" == "None" ]]; then
    log_error "No IAM Role attached"
    exit 1
fi

log_info "IAM Role attached: ${ROLE_NAME}"