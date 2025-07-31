+---------------------+        +-------------------------+       +------------------------+
|     GitHub Repo     |  CI/CD |    GitHub Actions       |       |       Terraform        |
|  (code + workflows) | -----> | - Terraform apply       | ----> | - AWS Infra Provision  |
+---------------------+        | - Docker build & push   |       +------------------------+
                               | - Deploy to EKS         |
                               +-------------------------+

             |                                                     |
             v                                                     v

+--------------------+                                +-----------------------+
|  Amazon ECR Repo    |                                |  AWS Secrets Manager   |
|  (Docker Images)    | <--------------------------+  |  Multi-region secrets  |
+--------------------+                            |   +-----------------------+
                                                  |
                                                  v

+----------------------+                +--------------------------+
|    Amazon EKS        | <------------> |  IAM Roles & Policies     |
|  (Kubernetes Cluster)|                | (Pod IRSA, Access Control)|
+----------------------+                +--------------------------+

         |   |      |                                  |
         |   |      v                                  v
         |   |  +----------------+              +-------------------+
         |   |  |  Kubernetes    |              |   VPC Endpoint    |
         |   |  |  Pods / App    |              | (DynamoDB Access) |
         |   |  +----------------+              +-------------------+
         |   |            |                                |
         |   |            v                                v
         |   |      +-------------+               +-----------------+
         |   |      |  DynamoDB   |               |  AWS WAF + ALB  |
         |   |      |  (NoSQL DB) |               | (Load Balancer) |
         |   |      +-------------+               +-----------------+
         |   |            |                               |
         |   |            |                               v
         |   |            +----------------------------> Internet
         |   |
         |   +------------------------------------+
         |                                        |
         |                                        v
+-----------------------+              +-------------------------+
| Amazon CloudFront +    |              | AWS Lambda@Edge         |
| ACM + Geo DNS + WAF    | <------------+ (Geo redirect & security)|
+-----------------------+              +-------------------------+

                             Monitoring & Alerting
             +---------------------------------------------+
             | CloudWatch Metrics & Alarms                   |
             | SNS Topic (Email + Slack + WhatsApp Lambda)  |
             +---------------------------------------------+

