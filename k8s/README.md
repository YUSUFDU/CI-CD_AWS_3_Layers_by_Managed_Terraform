# Kubernetes Manifests

## Purpose  
Kubernetes resource definitions for the EKS application.

## Contents  
- `deployment.yaml`: Deployment, Service, HPA, and Ingress manifests.

## Relations  
Uses container images from ECR.  
Ingress secured by ACM and ALB.  
Includes autoscaling and readiness/liveness probes.

## Usage  
Dynamically adjusted and applied via GitHub Actions per environment.
