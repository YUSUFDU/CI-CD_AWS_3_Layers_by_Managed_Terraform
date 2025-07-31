output "dynamodb_table_name" {
  value = aws_dynamodb_table.example_table.name
}

output "dynamodb_table_arn" {
  value = aws_dynamodb_table.example_table.arn
}
