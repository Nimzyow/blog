variable "env" {
  type        = string
  description = "env name"
  default     = "dev"
  validation {
    condition     = contains(["dev", "stage", "prod"], var.env)
    error_message = "Valid values for env are 'dev', 'stage', 'prod'"
  }
}
