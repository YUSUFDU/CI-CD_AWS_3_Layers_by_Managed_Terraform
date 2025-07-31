# Lambda Functions

## Purpose  
Contains Lambda functions for global geo-redirect and alert notifications.

## Contents  
- `geo-redirect-src/`: Source code for geo redirect.  
- `geo-redirect.zip`: Packaged Lambda function.  
- `whatsapp-alert-src/`: Source code for WhatsApp alerts.  
- `whatsapp-alert.zip`: Packaged function.

## Relations  
Access secrets from Secrets Manager.  
Integrated with CloudFront and API Gateway.  
Deployed via GitHub Actions pipeline.

## Usage  
Update source code, build zip packages, deploy via Terraform.
