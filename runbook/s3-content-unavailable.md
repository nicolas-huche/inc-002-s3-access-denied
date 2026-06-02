## When to use

Use this runbook when the application is reachable but fails to display the content retrieved from Amazon S3.

Note: This runbook was written for the INC-002 lab environment but follows generic EC2-to-S3 troubleshooting patterns.

## How to use

The hypotheses are divided into different sections; however, the instructions must be followed linearly. 

Skipping instructions is only permitted if one of the hypotheses before the last one turns out to be the root cause. In that case, it must skip to the validation section.

## Prerequisites

- Access to the AWS Management Console
- Permission to start AWS Systems Manager Session Manager sessions
- Permission to inspect EC2, IAM and S3 resources
- Access to the diagnostic scripts referenced by this runbook

## Decision Tree

```txt
Unable to load content
├── S3 Request Missing
├── Object Missing
├── IAM Role Missing
├── IAM Policy Missing
├── IAM Policy Misconfiguration
└── Bucket Policy Misconfiguration
```

## S3 Request Missing

### Investigation

Inspect the application configuration in a Session Manager 

Verify whether the application is configured to retrieve an object from Amazon S3.

### Remediation

If the expected S3 object request can be determined from available evidence, correct the application configuration.

Otherwise, escalate to the application owner.

## Object Missing

### Investigation

Inspect the S3 object referenced by the application with [inspect_object.sh](../scripts/diagnose/inspect_object.sh).

Verify whether the referenced bucket and object exist.

### Remediation

If the expected object can be determined from available evidence, restore the missing object.

Otherwise, escalate to the application owner.

## IAM Role Missing

### Investigation

Inspect whether an IAM Role is attached to the EC2 instance with [inspect_role.sh](../scripts/diagnose/inspect_role.sh).

### Remediation

If the expected IAM Role can be determined from available evidence, attach it to the EC2 instance.

Otherwise, escalate to the service owner.

## IAM Policy Missing

### Investigation

Inspect whether any IAM Policy is attached to the IAM Role with [inspect_policy.sh](../scripts/diagnose/inspect_policy.sh).

### Remediation

If the expected IAM Policy can be determined from available evidence, attach it to the IAM Role.

Otherwise, escalate to the service owner.

## IAM Policy Misconfiguration

### Investigation

Inspect the permissions granted by the IAM Policy with [inspect_permissions.sh](../scripts/diagnose/inspect_permissions.sh).

Verify whether `s3:GetObject` is properly allowed.

### Remediation

Correct the invalid IAM policy configuration by adding the required `s3:GetObject` permission properly.

## Bucket Policy Misconfiguration

### Investigation

Inspect the bucket policy with [inspect_bucket_policy.sh](../scripts/diagnose/inspect_bucket_policy.sh).

Verify whether the bucket policy denies access to the S3 object.

### Remediation

Correct the invalid bucket policy configuration by removing the rule denying access to the S3 object.

## Validation

Access http://(instance-public-ip)

Confirm that the application displays the S3 content

## Escalation

Escalate if:

- Application malfunction
- AWS credential retrieval issue
- AWS service degradation
- Unexpected application or infrastructure changes
- None of the suggested hypotheses was identified as the root cause

## References

### Architecture

- [architecture.md](../architecture/architecture.md)
- [topology.svg](../architecture/diagrams/topology.svg)
- [request-flow.svg](../architecture/diagrams/request-flow.svg)

### Troubleshooting Scripts

- [inspect_object.sh](../scripts/diagnose/inspect_object.sh)
- [inspect_role.sh](../scripts/diagnose/inspect_role.sh)
- [inspect_policy.sh](../scripts/diagnose/inspect_policy.sh)
- [inspect_pormissions.sh](../scripts/diagnose/inspect_permissions.sh)
- [inspect_bucket_policy.sh](../scripts/diagnose/inspect_bucket_policy.sh)
