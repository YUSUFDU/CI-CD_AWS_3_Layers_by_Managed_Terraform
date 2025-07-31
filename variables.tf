variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "us_east_1_region" {
  description = "AWS us-east-1 region for billing and lambda@edge"
  type        = string
  default     = "us-east-1"
}

variable "billing_threshold" {
  description = "Billing alarm threshold in USD"
  type        = number
  default     = 100
}

variable "allowed_ips" {
  description = "List of IPs allowed during restricted hours"
  type        = list(string)
  default     = ["203.0.113.100/32", "198.51.100.200/32"]
}

variable "primary_email" {
  description = "Primary email for SNS notifications"
  type        = string
  default     = "y.duymac@gmail.com"
}

variable "secondary_email" {
  description = "Backup email for SNS notifications"
  type        = string
  default     = "backup@example.com"
}

variable "slack_webhook_url" {
  description = "Slack webhook URL for alerts"
  type        = string
  sensitive   = true
}

variable "twilio_auth_token" {
  description = "Twilio auth token for WhatsApp alerting"
  type        = string
  sensitive   = true
}

variable "twilio_account_sid" {
  description = "Twilio Account SID for WhatsApp"
  type        = string
  sensitive   = true
}

variable "twilio_whatsapp_from" {
  description = "Twilio WhatsApp sender number"
  type        = string
}

variable "whatsapp_to" {
  description = "WhatsApp recipient number"
  type        = string
}

variable "github_oidc_subject" {
  description = "GitHub Actions OIDC subject"
  type        = string
  default     = "repo:your-org/example_repo:ref:refs/heads/main"
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
}

variable "domain_name" {
  description = "Primary domain name"
  type        = string
  default     = "example.com"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "secure-eks-cluster"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}
