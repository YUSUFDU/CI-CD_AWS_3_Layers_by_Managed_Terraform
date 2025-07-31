variable "cluster_name" {
  description = "Cluster name for tagging"
  type        = string
}

resource "aws_dynamodb_table" "example_table" {
  name           = "${var.cluster_name}-example-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = {
    Environment = var.cluster_name
  }
}
