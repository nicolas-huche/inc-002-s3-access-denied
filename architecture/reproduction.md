## Overview

This document describes how to provision the environment, validate the healthy state, reproduce the incident, and clean up the resources.

## Prerequisites

- AWS account
- AWS CLI configured
- SSH client

## Environment Provisioning

### S3 Bucket Setup

1. Create the S3 bucket named "inc-002-s3".
2. Upload the application content object named "content.txt".

### IAM Setup

3. Create the IAM policy granting access to the S3 object.
4. Create the IAM role for EC2.
5. Attach the policy to the role.

### EC2 Instance Setup

6. Create a security group allowing inbound SSH and HTTP traffic
7. Enable auto-assign public IP
8. Upload [user-data.sh](./user-data.sh) into the User Data field.
9. Launch the instance.
10. Attach the IAM role created in the previous section.

### Baseline Validation

11. Access http://<public-ip>
12. Confirm that the application displays the S3 content

## Failure Injection

Run: scripts/chaos/inject_failure.sh

## Investigation and Recovery

See: runbooks/recover_s3_access.md

## Teardown

Remove the resources created for the lab:

1. Terminate the EC2 instance.
2. Delete the S3 bucket and objects.
3. Delete the IAM policy.
4. Delete the IAM role.