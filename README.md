# INC-002 — S3 Access Denied Investigation

Simulated AWS incident involving application content retrieval failure caused by an IAM policy misconfiguration affecting access to Amazon S3.

| Severity | Service | Root Cause                  | MTTD | MTTR  |
| -------- | ------- | --------------------------- | ---- | ----- |
| P2       | IAM/S3  | IAM policy misconfiguration | 3m31 | 10m10 |

> This repository documents a controlled incident simulation created for learning and portfolio purposes.
> The environment was manually provisioned in AWS and the incident was intentionally triggered and investigated using operational tooling and documented evidence.

## TL;DR

An EC2-hosted application became unable to display content stored in Amazon S3 after an IAM policy change introduced an incorrect resource scope for object-level permissions.

The incident was investigated through application inspection, S3 object validation, IAM role and policy verification, and CloudTrail event analysis.

Functionality was restored by publishing a corrected IAM policy version that granted access to the required S3 object and validating recovery through browser testing.

## Architecture

![Topology](architecture/diagrams/topology.svg)

## I want to...

| Goal                                | Go to                                                                      |
| ----------------------------------- | -------------------------------------------------------------------------- |
| Understand the environment          | [`architecture/architecture.md`](architecture/architecture.md)             |
| Reproduce the lab                   | [`architecture/reproduction.md`](architecture/reproduction.md)             |
| Follow the incident timeline        | [`incident/timeline.md`](incident/timeline.md)                             |
| Read the postmortem                 | [`incident/postmortem.md`](incident/postmortem.md)                         |
| See collected evidence              | [`artifacts/manifest.md`](artifacts/manifest.md)                           |
| Run the scripts                     | [`scripts/README.md`](scripts/README.md)                                   |
| Follow the troubleshooting workflow | [`runbooks/s3-content-unavailable.md`](runbooks/s3-content-unavailable.md) |

## Repository Structure

```txt
inc-002-s3-access-denied/
├── architecture/
├── artifacts/
├── incident/
├── runbooks/
├── scripts/
├── README.md
└── LICENSE
```
