# Shared-Secret Module

## Purpose  
Manages multi-region Secrets Manager secrets centrally.

## Contents  
- `main.tf`: Defines secrets and versions per region.  
- `variables.tf`: Parameters like secret name, regions, and secret map.  
- `outputs.tf`: Outputs secret ARNs and names.

## Relations  
Used by Lambda, EKS, and other services for secret access.  
IAM roles grant permission to these secrets.

## Usage  
Pass parameters:  
- `name`  
- `regions`  
- `secret_map`
