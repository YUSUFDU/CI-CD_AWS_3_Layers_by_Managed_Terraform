
# Temel Ayarlar
output "aws_region" {
  value = var.aws_region
}

output "us_east_1_region" {
  value = var.us_east_1_region
}

output "billing_threshold" {
  value = var.billing_threshold
}

output "allowed_ips" {
  value = var.allowed_ips
}

output "primary_email" {
  value = var.primary_email
}

output "secondary_email" {
  value = var.secondary_email
}

output "slack_webhook_url" {
  value     = var.slack_webhook_url
  sensitive = true
}

output "twilio_auth_token" {
  value     = var.twilio_auth_token
  sensitive = true
}

output "twilio_account_sid" {
  value     = var.twilio_account_sid
  sensitive = true
}

output "twilio_whatsapp_from" {
  value = var.twilio_whatsapp_from
}

output "whatsapp_to" {
  value = var.whatsapp_to
}

output "github_oidc_subject" {
  value = var.github_oidc_subject
}

output "acm_certificate_arn" {
  value = var.acm_certificate_arn
}

output "domain_name" {
  value = var.domain_name
}

output "cluster_name" {
  value = var.cluster_name
}

output "dynamodb_table_name" {
  value = module.dynamodb_table.dynamodb_table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb_table.dynamodb_table_arn
}

output "ecr_repo_url" {
  value = aws_ecr_repository.example_repo.repository_url
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "billing_alarm_state" {
  value = aws_cloudwatch_metric_alarm.billing_high_cost.state_value
}

output "cpu_alarm_state" {
  value = aws_cloudwatch_metric_alarm.high_cpu_alarm.state_value
}

output "waf_sqli_alarm_state" {
  value = aws_cloudwatch_metric_alarm.waf_sqli_blocks.state_value
}

output "allowed_ips_output" {
  value = var.allowed_ips
}

output "geo_lambda_arn" {
  value = aws_lambda_function.geo_redirect.qualified_arn
}

output "whatsapp_lambda_arn" {
  value = aws_lambda_function.whatsapp_notify.arn
}

output "slack_webhook_secret_arn" {
  value     = aws_secretsmanager_secret.slack_webhook.arn
  sensitive = true
}

output "whatsapp_secret_arn" {
  value     = aws_secretsmanager_secret.whatsapp.arn
  sensitive = true
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.example.id
}

output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "route53_zone_id" {
  value = aws_route53_zone.primary.zone_id
}

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}

output "sns_topic_arn" {
  value = aws_sns_topic.alerts.arn
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.app_logs.name
}

output "lambda_edge_qualified_arn" {
  value = aws_lambda_function.geo_redirect.qualified_arn
}
