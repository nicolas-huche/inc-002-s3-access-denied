## Overview

This document describes how to provision the environment, validate the healthy state, reproduce the incident, and clean up the resources.

## Prerequisites

- AWS account
- AWS CLI configured
- AWS Console

## Environment Provisioning

### S3 Bucket Setup

1. Create the S3 bucket named "inc-002-s3".
2. Upload the application content object named "content.txt".

### IAM Setup

3. Create an IAM policy using [healthy-policy.sh](./policies/healthy-policy.json)
4. Create the IAM role for EC2.
5. Attach the created policy to the role.
6. Attach ```AmazonSSMManagedEC2InstanceDefaultPolicy``` policy to the role.

### EC2 Instance Setup

6. Create a security group allowing inbound SSH and HTTP traffic
7. Enable auto-assign public IP
8. Upload [user-data.sh](./user-data.sh) into the User Data field.
9. Launch the instance.
10. Attach the IAM role created in the previous section.

### Baseline Validation

11. Access http://(instance-public-ip)
12. Confirm that the application displays the S3 content

## Failure Injection

Run: [inject_failure.sh](../scripts/README.md)

## Investigation and Recovery

See: [s3-content-unavailable.md](../runbook/s3-content-unavailable.md)

## Teardown

Remove the resources created for the lab:

1. Terminate the EC2 instance.
2. Delete the S3 bucket and objects.
3. Delete the IAM policy.
4. Delete the IAM role.