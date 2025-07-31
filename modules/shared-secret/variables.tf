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
