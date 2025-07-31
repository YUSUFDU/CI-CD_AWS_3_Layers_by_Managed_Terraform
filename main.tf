terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "secure-vpc"
  cidr = var.vpc_cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = var.cluster_name
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  subnets = module.vpc.private_subnets
  vpc_id  = module.vpc.vpc_id

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3
      instance_types   = ["t3.medium"]
      capacity_type    = "SPOT"
      tags = {
        schedule = "weekend-shutdown"
      }
    }
  }

  enable_irsa = true

  tags = {
    Environment = var.cluster_name
    Terraform   = "true"
  }
}

module "shared_secret" {
  source  = "./modules/shared-secret"
  name    = "whatsapp-creds"
  regions = ["eu_central_1", "us_west_2"]
  secret_map = {
    TWILIO_ACCOUNT_SID = var.twilio_account_sid
    TWILIO_AUTH_TOKEN  = var.twilio_auth_token
    WHATSAPP_FROM      = var.twilio_whatsapp_from
    WHATSAPP_TO        = var.whatsapp_to
  }
}

module "dynamodb_table" {
  source       = "./modules/dynamodb_table"
  cluster_name = var.cluster_name
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = module.vpc.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = module.vpc.public_route_table_ids

  tags = {
    Name = "dynamodb-vpc-endpoint"
  }
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "${var.cluster_name}-dynamodb-access"
  description = "Allow access to DynamoDB example table"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = [
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:DeleteItem"
      ]
      Resource = module.dynamodb_table.dynamodb_table_arn
    }]
  })
}

resource "aws_iam_role" "app_pod_dynamodb_role" {
  name = "${var.cluster_name}-app-pod-dynamodb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "app_pod_dynamodb_attach" {
  role       = aws_iam_role.app_pod_dynamodb_role.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}

resource "aws_sns_topic" "alerts" {
  name = "cloudwatch-alarms"
}

resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.primary_email
}

resource "aws_sns_topic_subscription" "secondary_email_alerts" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.secondary_email
}

resource "null_resource" "package_lambda_functions" {
  provisioner "local-exec" {
    command = "bash scripts/package-lambda.sh"
  }
  
  triggers = {
    geo_redirect_src_hash   = filesha256("lambda/geo-redirect-src/index.js")
    whatsapp_alert_src_hash = filesha256("lambda/whatsapp-alert-src/index.js")
  }
}


# Diğer kaynaklar, alarmlar, Lambda, CloudFront, WAF, Route53, GitHub Actions workflow vs. modüller ile devam edecek...
