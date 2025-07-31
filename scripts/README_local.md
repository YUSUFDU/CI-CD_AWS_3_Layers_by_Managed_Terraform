# Helper Scripts

## Purpose  
Automation scripts supporting Terraform workflows and Lambda packaging.

## Contents  
- `git-auto-push.sh`: Automatically commits and pushes updated workflow files.  
- `package-lambda.sh`: Packages Lambda source code directories into zip files (`geo-redirect.zip`, `whatsapp-alert.zip`).

## Relations  
- `package-lambda.sh` is called by Terraform via a `null_resource` to keep Lambda deployment packages up-to-date before deployment.  
- `git-auto-push.sh` automates GitHub Actions workflow versioning after Terraform changes.

## Usage  
- Run `package-lambda.sh` manually or let Terraform trigger it automatically when Lambda source code changes.  
- Use `git-auto-push.sh` after Terraform applies to update workflows in GitHub.
