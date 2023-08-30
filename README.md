<!-- BEGIN_TF_DOCS -->
# terraform-aws-cloudtrail

This module creates a CloudTrail trail, a CloudWatch log group, and an S3 bucket for storing CloudTrail logs.

## Usage

### Basic

```hcl
include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../..//."
}

inputs = {
  enabled = true

  region      = "us-east-2"
  environment = "test"

  name = "dt-terraform-test"

  bucket_force_destroy = true

  tags = {
    "Company" = "DeveloperTown"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.36.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail) | resource |
| [aws_cloudwatch_log_group.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.cloudtrail](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Force destroy the bucket | `bool` | `false` | no |
| <a name="input_bucket_id"></a> [bucket\_id](#input\_bucket\_id) | The bucket id | `string` | `""` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket to create | `string` | `""` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | The prefix to use for the bucket | `string` | `"trails"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | KMS key ARN to use to encrypt the logs delivered by CloudTrail. | `string` | `""` | no |
| <a name="input_log_bucket_id"></a> [log\_bucket\_id](#input\_log\_bucket\_id) | The log bucket id | `string` | `""` | no |
| <a name="input_log_bucket_prefix"></a> [log\_bucket\_prefix](#input\_log\_bucket\_prefix) | The log prefix | `string` | `"log/"` | no |
| <a name="input_log_kms_key_id"></a> [log\_kms\_key\_id](#input\_log\_kms\_key\_id) | The AWS KMS key to be used to encrypt the cloudwatch logs. | `string` | `""` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Number of days to retain logs | `number` | `7` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `"ecs-cluster"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region in which the resources will be created | `string` | `null` | no |
| <a name="input_sns_alarm_topic_arn"></a> [sns\_alarm\_topic\_arn](#input\_sns\_alarm\_topic\_arn) | The SNS Topic ARN to use for Cloudwatch Alarms | `string` | `""` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix to be added to the name of each resource | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'Unit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | Bucket ARN |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | Bucket ID |
<!-- END_TF_DOCS -->