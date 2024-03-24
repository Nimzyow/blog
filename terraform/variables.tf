variable "env" {
  type        = string
  description = "env name"
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "production"], var.env)
    error_message = "Valid values for env are 'dev', 'staging', 'production'"
  }
}
