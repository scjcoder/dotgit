# AWS CLI Configuration Guide

## Overview

This document covers the AWS CLI configuration and utilities included in the dotfiles setup.

## Configuration Structure

```
config/aws/
├── config              # AWS CLI configuration
└── credentials.example # Template for AWS credentials
```

## Profile Setup

### Default Configuration

The default AWS CLI configuration includes:

```ini
[default]
region = us-east-1
output = json
cli_auto_prompt = on
cli_history = enabled
```

### Multiple Profiles

Example profile setup:

```ini
[profile dev]
region = us-east-1
output = json

[profile prod]
region = us-east-1
output = json
mfa_serial = arn:aws:iam::ACCOUNT_ID:mfa/YOUR_USERNAME
```

## Available Aliases

### Profile Management
- `awsp` - Interactive profile switching using fzf
- `awswho` - Display current AWS identity
- `aws-account` - Show current AWS account ID

### EC2 Management
- `ec2ls` - List EC2 instances with details
- `ec2start` - Start EC2 instances
- `ec2stop` - Stop EC2 instances

### S3 Operations
- `s3ls` - List S3 buckets
- `s3cp` - Copy files to/from S3
- `s3sync` - Sync directories with S3

### Other Utilities
- `aws-cost` - Show monthly AWS costs
- `aws-regions` - List all AWS regions
- `logs` - Tail CloudWatch logs
- `ssm-session` - Start SSM session

## Security Best Practices

1. **MFA Setup**
   - Enable MFA for all profiles
   - Use temporary credentials
   - Configure `mfa_serial` in profile

2. **Credentials Management**
   - Never commit credentials file
   - Use AWS SSO where possible
   - Rotate access keys regularly

3. **Profile Isolation**
   - Use separate profiles for different environments
   - Set appropriate permissions per profile
   - Use role assumption when possible

## Common Tasks

### Setting Up a New Profile

1. Edit AWS config:
   ```bash
   vim ~/.aws/config
   ```

2. Add profile configuration:
   ```ini
   [profile new-profile]
   region = us-east-1
   output = json
   ```

3. Add credentials:
   ```bash
   aws configure --profile new-profile
   ```

### Using AWS SSO

1. Configure SSO profile:
   ```ini
   [profile sso]
   sso_start_url = https://your-org.awsapps.com/start
   sso_region = us-east-1
   sso_account_id = 123456789012
   sso_role_name = RoleName
   region = us-east-1
   output = json
   ```

2. Login to SSO:
   ```bash
   aws sso login --profile sso
   ```

## Troubleshooting

### Common Issues

1. **Invalid Credentials**
   ```bash
   awswho  # Check current identity
   aws configure list  # Verify configuration
   ```

2. **MFA Issues**
   - Verify MFA serial number
   - Check time synchronization
   - Use `aws sts get-session-token`

3. **Region Issues**
   ```bash
   aws-use-region us-east-1  # Switch regions
   aws-regions  # List available regions
   ```

### Debug Mode

Enable AWS CLI debug mode:
```bash
export AWS_DEBUG=true
aws s3 ls  # Will show detailed debug output
```
