### C-001 — 2026-06-02T14:48:31Z — Initial incident notification

The application is reachable, but it is unable to display the content retrieved from Amazon S3.

Impact is currently limited to S3-backed content rendering for the EC2-hosted application. Investigation is in progress.

Next update will be provided once the root cause is identified.

### C-002 — 2026-06-02T14:55:28Z — Root cause identified

The issue was identified as an IAM policy misconfiguration affecting access to the application content stored in Amazon S3.

Remediation is being applied. Validation is in progress.

### C-003 — 2026-06-02T14:58:56Z — Incident resolved

S3 content access has been restored and validated successfully.

The corrected IAM policy document was set as the default policy version, and browser validation confirmed that the application now displays the S3 content.

### C-004 — 2026-06-02T14:58:56Z — Investigation completed

Post-resolution review confirmed that the incident was caused by an IAM policy change affecting access to application content stored in Amazon S3.

The incident is now considered fully closed. A postmortem will be completed for documentation purposes.