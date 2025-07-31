# README_LOCAL.md — GitHub Actions Deploy Workflow for AWS EKS

## Overview

This document explains the usage and configuration of the GitHub Actions deployment pipeline designed for Terraform and AWS EKS.

The workflow supports three environments: **dev**, **test**, and **prod**.

- For `dev` and `test` branches, deployments happen automatically on push.  
- For the `prod` branch, deployment is triggered manually via `workflow_dispatch`.

---

## Workflow Steps

- Triggered by branch push (`dev`, `test`) or manual workflow dispatch (`prod`).  
- AWS credentials are securely fetched from GitHub Secrets.  
- Environment-specific backend and variable files (`backend-<env>.tfvars`, `<env>.tfvars`) are loaded dynamically.  
- Terraform init, plan, and apply commands are executed accordingly.  
- Docker images are built and pushed to the environment’s respective ECR repository.  
- Kubernetes manifests are applied using environment-specific image tags, and rollout status is monitored.  
- Rollback is triggered on deployment failure (prod environment).

---

## Environment Configuration

| Environment | Branch Name | Backend Config File       | Terraform Variable File | ECR Repository Secret       | Deployment Trigger          |
|-------------|-------------|--------------------------|------------------------|-----------------------------|----------------------------|
| dev         | dev         | backend-dev.tfvars        | dev.tfvars             | `ECR_REPO_DEV` (GitHub Secret) | Automatic on push          |
| test        | test        | backend-test.tfvars       | test.tfvars            | `ECR_REPO_TEST`              | Automatic on push          |
| prod        | main        | backend-prod.tfvars       | prod.tfvars            | `ECR_REPO_PROD`              | Manual trigger (`workflow_dispatch`) |

---

## Required Secrets

The following secrets must be configured in the GitHub repository settings:

- `AWS_REGION`: AWS region, e.g., `eu-central-1`  
- `AWS_ROLE_ARN`: ARN of the IAM role assumed by GitHub Actions  
- `ECR_REPO_DEV`, `ECR_REPO_TEST`, `ECR_REPO_PROD`: ECR repository URLs for respective environments  
- (Optional) Notification secrets for Slack, email, etc.

---

## Manual Deployment for Production

- The `prod` environment deployment is disabled on push events to avoid accidental releases.  
- Deploying to production requires manual triggering via the GitHub Actions UI using the **Run workflow** button.

---

## Usage Instructions

1. Push code to `dev` or `test` branches to trigger automatic deployment.  
2. For production, trigger the deployment manually via workflow dispatch.  
3. The workflow automatically sets the environment context and configuration.  
4. Terraform infrastructure changes are applied.  
5. Docker images are built and pushed to the correct ECR repository with environment tags.  
6. Kubernetes deployments are updated with the correct image and rollout status is verified.  
7. Rollback is performed automatically on deployment failure for production.

---

## Extensibility

- Notifications can be integrated (Slack, email, SMS).  
- GitHub Environment protection rules and approval gates can be added for enhanced security.  
- Additional testing and validation steps can be incorporated.  
- Support for multi-account or multi-region deployments is possible.

---

## File Structure and Relationships

| File                          | Description                                         |
|-------------------------------|---------------------------------------------------|
| `.github/workflows/deploy.yml` | The GitHub Actions workflow for CI/CD              |
| `backend-dev.tfvars`           | Backend configuration for the dev environment       |
| `backend-test.tfvars`          | Backend configuration for the test environment      |
| `backend-prod.tfvars`          | Backend configuration for the prod environment      |
| `dev.tfvars`                  | Terraform variables for the dev environment           |
| `test.tfvars`                 | Terraform variables for the test environment          |
| `prod.tfvars`                 | Terraform variables for the prod environment          |
| `k8s/deployment-dev.yaml`     | Kubernetes manifests for dev environment               |
| `k8s/deployment-test.yaml`    | Kubernetes manifests for test environment              |
| `k8s/deployment-prod.yaml`    | Kubernetes manifests for prod environment              |

---

For troubleshooting, please check workflow logs and Terraform outputs.

Contact your DevOps team for assistance or customization requests.

---

This README is intended to help all team members understand, operate, and maintain the GitHub Actions deployment process effectively.
