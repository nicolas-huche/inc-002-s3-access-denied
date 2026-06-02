#!/usr/bin/env bash

set -euo pipefail

source "$(dirname "$0")/../lib/common.sh"

INSTANCE_ID=$(
    aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" \
        --query "Reservations[*].Instances[*].InstanceId" \
        --output text
)

ROLE_NAME=$(
    aws ec2 describe-instances \
        --instance-ids "${INSTANCE_ID}" \
        --query "Reservations[*].Instances[*].IamInstanceProfile.Arn" \
        --output text \
    | awk -F'/' '{print $NF}'
)

POLICY_ARN=$(
    aws iam list-attached-role-policies \
        --role-name "${ROLE_NAME}" \
        --query "AttachedPolicies[*].PolicyArn" \
        --output text
)

log_warn "Replacing IAM policy document with failure policy"

aws iam create-policy-version \
    --policy-arn "${POLICY_ARN}" \
    --policy-document file://architecture/policies/failure-policy.json \
    --set-as-default

log_info "Failure injection completed"