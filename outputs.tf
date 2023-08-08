output "bucket_id" {
  value       = one(module.cloudtrail_s3_bucket[*].bucket_id)
  description = "Bucket ID"
}

output "bucket_arn" {
  value       = one(module.cloudtrail_s3_bucket[*].bucket_arn)
  description = "Bucket ARN"
}
