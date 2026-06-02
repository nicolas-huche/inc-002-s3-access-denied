## Manifest Overview

Artifacts generated during the INC-002 S3 Access Denied simulation.

## Artifact Timeline

### Failure Evidence

| Timestamp (UTC) | Artifact | Description |
|---|---|---|
| 2026-06-02T14:48:31Z | [browser_content_unavailable.png](./screenshots/2026-06-02T14:48:31Z_browser_content_unavailable.png) | Browser shows the application reachable but unable to load S3 content |

### Diagnostic Evidence

| Timestamp (UTC) | Artifact | Description |
|---|---|---|
| 2026-06-02T14:52:02Z | [inspect_application.txt](./cli/2026-06-02T14:52:02Z_inspect_application.txt) | Application process, listener, and Flask code showing the S3 GetObject request for s3://inc-002-s3/content.txt |
| 2026-06-02T14:53:55Z | [inspect_object.txt](./cli/2026-06-02T14:53:55Z_inspect_object.txt) | S3 object existence check for s3://inc-002-s3/content.txt |
| 2026-06-02T14:54:17Z | [inspect_role.txt](./cli/2026-06-02T14:54:17Z_inspect_role.txt) | IAM role attachment check showing INC002S3AccessRole attached to the instance |
| 2026-06-02T14:54:53Z | [inspect_policy.txt](./cli/2026-06-02T14:54:53Z_inspect_policy.txt) | IAM policy attachment check showing INC002S3AccessPolicy attached to INC002S3AccessRole |
| 2026-06-02T14:55:28Z | [inspect_permissions.txt](./cli/2026-06-02T14:55:28Z_inspect_permissions.txt) | IAM policy document showing S3 object actions scoped to the bucket ARN instead of the object ARN |

### Remediation Evidence

| Timestamp (UTC) | Artifact | Description |
|---|---|---|
| 2026-06-02T14:58:41Z | [correct-policy.json](./correct-policy.json) | Correct IAM policy document granting S3 object actions on arn:aws:s3:::inc-002-s3/content.txt |
| 2026-06-02T14:58:41Z | [remediation.txt](./cli/2026-06-02T14:58:41Z_remediation.txt) | IAM create-policy-version command setting the corrected policy document as the default version |

### Validation Evidence

| Timestamp (UTC) | Artifact | Description |
|---|---|---|
| 2026-06-02T14:58:56Z | [browser_content_available.png](./screenshots/2026-06-02T14:58:56Z_browser_content_available.png) | Browser confirms the application displays S3 content after the policy update |

### Origin Evidence

| Timestamp (UTC) | Artifact | Description |
|---|---|---|
| 2026-06-02T14:58:56Z | [cloudtrail_policy.json](./cli/2026-06-02T14:58:56Z_cloudtrail_policy.json) | CloudTrail CreatePolicyVersion event for INC002S3AccessPolicy with the corrected S3 object resource |
