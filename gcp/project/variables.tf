variable "billing_account" {
  description = "Billing account ID"
  type = string 
}

variable "billing_limit" {
  description = "Monthly billing limit in EUR"
  type = number
  default = 10
}

variable "billing_notification_email" {
  description = "Email address for billing notifications"
  type = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type = string
}

variable "project_id" {
  description = "Project ID"
  type = string
}

variable "project_name" {
  description = "Project name"
  type = string
}

variable "project_services" {
  description = "List of services to enable for the project"
  type = list(string)
  default = []
}

variable "org_id" {
  description = "Organization ID"
  type = string
}