## Overview

This directory contains simple diagnostic utilities used throughout the INC-002 lab environment.

| Script | Purpose |
|----------|----------|
| `inspect_object.sh` | Verify whether an S3 object exists |
| `inspect_role.sh` | Verify whether an IAM Role is attached to the running EC2 instance |
| `inspect_policy.sh` | List IAM Policies attached to an IAM Role |
| `inspect_permissions.sh` | Inspect the policy document attached to an IAM Policy |
| `inspect_bucket_policy.sh` | Inspect the Bucket Policy attached to an S3 bucket |
| `inject_failure.sh` | Intentionally introduces an ARN typo in the IAM Policy |

## Dependencies

The scripts require:

- bash
- AWS CLI v2
- Python 3

## Usage

### Diagnose

Inspect S3 Object:

```bash
./scripts/diagnose/inspect_object.sh BUCKET_NAME OBJECT_NAME
```

Inspect IAM Role:

```bash
./scripts/diagnose/inspect_role.sh 
```

Inspect IAM Policy:

```bash
./scripts/diagnose/inspect_policy.sh ROLE_NAME
```

Inspect Permissions:

```bash
./scripts/diagnose/inspect_permissions.sh POLICY_NAME
```

Inspect Bucket Policy:

```bash
./scripts/diagnose/inspect_bucket_policy.sh BUCKET_NAME
```

### Chaos

Inject the simulated policy failure:

```bash
./scripts/chaos/inject_failure.sh
```

This adds more permissions, but breaks ARN.

