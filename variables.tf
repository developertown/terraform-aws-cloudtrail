variable "kms_key_id" {
  type        = string
  description = "KMS key ARN to use to encrypt the logs delivered by CloudTrail."
  default     = ""
}

variable "log_bucket_id" {
  description = "The log bucket id"
  type        = string
  default     = ""
}

variable "log_bucket_prefix" {
  description = "The log prefix"
  type        = string
  default     = "log/"
}

variable "log_kms_key_id" {
  type        = string
  description = "The AWS KMS key to be used to encrypt the cloudwatch logs."
  default     = ""
}

variable "log_retention_days" {
  type        = number
  description = "Number of days to retain logs"
  default     = 7
}

variable "sns_alarm_topic_arn" {
  type        = string
  description = "The SNS Topic ARN to use for Cloudwatch Alarms"
  default     = ""
}

variable "bucket_id" {
  description = "The bucket id"
  type        = string
  default     = ""
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket to create"
  default     = ""
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the bucket"
  default     = "trails"
}

variable "bucket_force_destroy" {
  type        = bool
  description = "Force destroy the bucket"
  default     = false
}