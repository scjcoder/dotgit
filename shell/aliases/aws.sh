#!/usr/bin/env bash

# AWS Profile management
alias awsp="aws configure list-profiles | fzf --height 40% --reverse | xargs -I{} aws configure set profile {}"
alias awswho="aws sts get-caller-identity"

# ECS shortcuts
alias ecs-clusters="aws ecs list-clusters | jq -r '.clusterArns[]'"
alias ecs-services="aws ecs list-services --cluster"

# EC2 shortcuts
alias ec2ls="aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,InstanceType,PublicIpAddress,PrivateIpAddress,Tags[?Key==`Name`].Value|[0]]' --output table"
alias ec2start="aws ec2 start-instances --instance-ids"
alias ec2stop="aws ec2 stop-instances --instance-ids"

# S3 shortcuts
alias s3ls="aws s3 ls"
alias s3cp="aws s3 cp"
alias s3sync="aws s3 sync"

# CloudWatch Logs
alias logs="aws logs tail --follow"

# SSM Session Manager
alias ssm-session="aws ssm start-session --target"

# Cost explorer
alias aws-cost="aws ce get-cost-and-usage --time-period Start=$(date -v-30d +%Y-%m-%d),End=$(date +%Y-%m-%d) --granularity MONTHLY --metrics BlendedCost --query 'ResultsByTime[].Total.BlendedCost'"

# Switch AWS Regions
alias aws-use-region="aws configure set region"

# List all AWS regions
alias aws-regions="aws ec2 describe-regions --query 'Regions[].RegionName' --output table"

# Get AWS account ID
alias aws-account="aws sts get-caller-identity --query 'Account' --output text"
