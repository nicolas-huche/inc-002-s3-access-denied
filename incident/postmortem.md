## Summary

On 2026-06-02, the EC2-hosted application remained reachable but was unable to load content from Amazon S3. Investigation identified an IAM policy misconfiguration that removed effective s3:GetObject access to the application content. Service was restored by applying the corrected policy version.

## Impact

Impact was limited to S3-backed content rendering in the INC-002 lab environment. The application remained reachable, but content stored in Amazon S3 could not be displayed. No additional impact was identified.

## Detection

The incident was initially detected when the application failed to display content retrieved from Amazon S3 while remaining otherwise reachable.

## Response

The investigation followed sequential validation of the application access path to Amazon S3.
The following components were validated in order:

1. Application configuration
2. S3 object existence
3. IAM role attachment
4. IAM policy attachment
5. IAM policy permissions

Findings:

1. Application configuration was correct
2. The target object existed in S3
3. The correct IAM role was attached to the instance
4. The expected IAM policy was attached to the role
5. The IAM policy granted object permissions on the bucket ARN instead of the target object ARN

This process eliminated unrelated hypotheses and isolated the failure to the IAM policy configuration.

## Root Cause Analysis

### Trigger

CloudTrail investigation identified a `CreatePolicyVersion` event shortly before the incident.

The previous policy version granted access only to the application object. A new policy version was then published to expand permissions by adding additional S3 object actions. During that change, the resource scope was modified from the target object ARN to the bucket ARN.

The new policy version was set as the default version, causing the application to lose effective access to `content.txt`.

### Root Cause

The root cause was an IAM policy misconfiguration.

The policy granted object-level S3 actions (`s3:GetObject`, `s3:PutObject`, and `s3:DeleteObject`) against the bucket ARN (`arn:aws:s3:::inc-002-s3`) instead of the object ARN required by the application. As a result, the EC2 role did not have effective permission to retrieve `content.txt`.

### Five Whys

1. Why did the application fail to display content?
   Because the S3 `GetObject` request failed.

2. Why did the request fail?
   Because the EC2 role lacked effective permission to access the target object.

3. Why did the role lack permission?
   Because the IAM policy used the bucket ARN for object-level actions.

4. Why was the incorrect policy active?
   Because a new policy version containing the misconfiguration was published as the default version.

5. Why was the issue not detected before impact occurred?
   Because no automated validation existed to verify application access to the S3 object after IAM policy changes.


### Contributing Factors

- IAM policy changes could be applied without validating application access to the target S3 object afterward.
- No automated functional test existed to verify S3 content retrieval after policy changes.
- The application exposed only a generic content-loading failure, requiring investigation of the underlying IAM permissions.

## Mitigation

The incident was resolved by publishing a new IAM policy version with the correct S3 object resource.

The previous policy granted object-level actions against the bucket ARN. The corrected version granted access to the target object (arn:aws:s3:::inc-002-s3/content.txt), restoring effective s3:GetObject permissions for the application.

Browser validation confirmed successful content retrieval after the policy update.

## Final Metrics

| Metric | Value |
|---|---|
| Detection to root cause identification | 7 minutes 26 seconds |
| Detection to recovery | 10 minutes 10 seconds |
| Total incident duration | 10 minutes 25 seconds |


## References

### Timeline
- [incident/timeline.md](../incident/timeline.md)

### Communications
- [incident/communications.md](../incident/communications.md)

### Artifact manifest
- [artifacts/manifest.md](../artifacts/manifest.md)

### Key evidence
- [artifacts/screeshots/inspect_application.txt](../artifacts/cli/2026-06-02T14:52:02Z_inspect_application.txt)
- [artifacts/screeshots/inspect_object.txt](../artifacts/cli/2026-06-02T14:53:55Z_inspect_object.txt)
- [artifacts/screeshots/inspect_role.txt](../artifacts/cli/2026-06-02T14:54:17Z_inspect_role.txt)
- [artifacts/screeshots/inspect_policy.txt](../artifacts/cli/2026-06-02T14:54:53Z_inspect_policy.txt)
- [artifacts/screeshots/inspect_permissions.txt](../artifacts/cli/2026-06-02T14:55:28Z_inspect_permissions.txt)
- [artifacts/screeshots/remediation.txt](../artifacts/cli/2026-06-02T14:58:41Z_remediation.txt)
- [artifacts/screeshots/cloudtrail_policy.json](../artifacts/cli/2026-06-02T14:54:53Z_inspect_policy.txt)