# DynamoDB Table Module

## Purpose  
Creates a high-availability, on-demand DynamoDB table with point-in-time recovery.

## Contents  
- `main.tf`: Table definition with billing mode and PITR enabled.  
- `variables.tf`: Parameters like cluster name.  
- `outputs.tf`: Table name and ARN outputs.

## Relations  
IAM roles and policies restrict access.  
VPC Endpoint secures network access.  
Backend services access the DynamoDB table.

## Usage  
Pass `cluster_name` parameter when calling this module.
