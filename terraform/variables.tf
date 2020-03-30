variable "stack_name" {
  type        = string
  description = "Friendly name of the terraform stack that we're building."
}

variable "bucket" {
  type        = string
  description = "Name of the remote s3 bucket and dynamodb locking table."
}

variable "key" {
  type        = string
  description = "Key/path for the terraform remote state file and locking table."
}

variable "dynamodb_table" {
  type        = string
  description = "Name of the terraform remote state dynamodb locking table."
}

variable "encrypt" {
  type        = bool
  description = "Is the terraform state file encrypted?"
}

variable "region" {
  type        = string
  description = "Region where the AWS resources will live."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "app_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the first app tier subnet."
}

variable "app_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the second app tier subnet."
}

variable "db_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the first db tier subnet."
}

variable "db_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the second db tier subnet."
}

variable "web_subnet_a_cidr" {
  type        = string
  description = "CIDR block for the first web tier subnet."
}

variable "web_subnet_b_cidr" {
  type        = string
  description = "CIDR block for the second web tier subnet."
}

variable "account_alias" {
  type        = string
  description = "Friendly name for the AWS account, used in s3 bucket names."
}

variable "scheduled_downtime_flag" {
  type        = string
  description = "Tag name that flags whether or not the resource has stop/start automation."
}

variable "scheduled_downtime_enabled" {
  type        = string
  description = "Set to true if the resource should be attached to stop/start automation."
}

variable "stop_schedule" {
  type        = string
  description = "What time does the application stop via automation?"
}

variable "start_schedule" {
  type        = string
  description = "What time does the application start via automation?"
}