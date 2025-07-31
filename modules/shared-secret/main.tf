variable "name" {
  description = "Secret name"
  type        = string
}

variable "regions" {
  description = "List of AWS regions provider aliases"
  type        = list(string)
}

variable "secret_map" {
  description = "Secret key-value pairs"
  type        = map(string)
}

resource "aws_secretsmanager_secret" "this" {
  for_each = toset(var.regions)
  provider = aws.${each.key}
  name     = var.name
}

resource "aws_secretsmanager_secret_version" "this" {
  for_each    = toset(var.regions)
  provider    = aws.${each.key}
  secret_id   = aws_secretsmanager_secret.this[each.key].id
  secret_string = jsonencode(var.secret_map)
}
