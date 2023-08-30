locals {
  enabled = var.enabled
  name    = "${var.name}-${var.environment}-${var.region}%{if var.suffix != ""}-${var.suffix}%{endif}"

  alarms = [
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-1
    {
      name        = "RootAccessCount"
      description = "Use of the root account has been detected"
      pattern     = "{$.userIdentity.type = Root && $.userIdentity.invokedBy NOT EXISTS && $.eventType != AwsServiceEvent }"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-2
    {
      name        = "UnauthorizedAPI"
      description = "Use of the unauthorized api calls has been detected"
      pattern     = "{($.errorCode = *UnauthorizedOperation ) || ($.errorCode = AccessDenied* )}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-3
    {
      name        = "ConsoleLoginWithoutMFA"
      description = "Use of the console by an account without MFA has been detected"
      pattern     = "{ ($.eventName = ConsoleLogin) && ($.additionalEventData.MFAUsed != Yes) && ($.userIdentity.type = IAMUser) && ($.responseElements.ConsoleLogin = Success) }"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-4
    {
      name        = "IamPolicyChanges"
      description = "IAM Policy have been changed"
      pattern     = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-5
    {
      name        = "CloudTrailChanges"
      description = "CloudTrail configuration have changed"
      pattern     = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-6
    {
      name        = "ConsoleAuthenticationFailures"
      description = "Console Authentication failure detected"
      pattern     = "{($.eventName=ConsoleLogin) && ($.errorMessage=Failed*)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-7
    {
      name        = "KMSDisabledOrDeleted"
      description = "Customer Managed Key disabled or scheduled for deletion"
      pattern     = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-8
    {
      name        = "S3PolicyChanges"
      description = "S3 Bucket Policies have changed"
      pattern     = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-9
    {
      name        = "ConfigConfigurationChanged"
      description = "AWS Config configuration changed"
      pattern     = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-10
    {
      name        = "SecurityGroupChanges"
      description = "Security groups have been changed"
      pattern     = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-11
    {
      name        = "NaclChanges"
      description = "Network Access Control has been changed"
      pattern     = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-12
    {
      name        = "NetworkGatewayChanges"
      description = "Network Gateways has been changed"
      pattern     = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-13
    {
      name        = "RouteTableChanges"
      description = "Route Tables been changed"
      pattern     = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
    },
    #https://docs.aws.amazon.com/securityhub/latest/userguide/cloudwatch-controls.html#cloudwatch-14
    {
      name        = "VPCChanges"
      description = "VPCs have changed"
      pattern     = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    }
  ]

  tags = merge(
    var.tags,
    {
      "Environment" = var.environment,
      "ManagedBy"   = "Terraform"
    }
  )
}

#tfsec:ignore:aws-cloudtrail-enable-at-rest-encryption
resource "aws_cloudtrail" "cloudtrail" {
  count = local.enabled ? 1 : 0

  name                          = local.name
  kms_key_id                    = var.kms_key_id
  s3_bucket_name                = one(module.cloudtrail_s3_bucket[*].bucket_id)
  s3_key_prefix                 = var.bucket_prefix
  include_global_service_events = true
  enable_logging                = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  cloud_watch_logs_role_arn     = one(aws_iam_role.cloudtrail[*].arn)
  cloud_watch_logs_group_arn    = "${one(aws_cloudwatch_log_group.cloudtrail[*].arn)}:*"

  depends_on = [module.cloudtrail_s3_bucket]
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  count = local.enabled ? 1 : 0

  name              = local.name
  kms_key_id        = var.log_kms_key_id
  retention_in_days = var.log_retention_days
}

resource "aws_iam_role" "cloudtrail" {
  count = local.enabled ? 1 : 0

  name               = "${local.name}-role"
  assume_role_policy = <<-EOF
   {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Effect": "Allow"
        }
      ]
   }
  EOF
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "cloudtrail" {
  statement {
    actions = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = [
      local.enabled ? "${one(aws_cloudwatch_log_group.cloudtrail[*].arn)}:*" : ""
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "cloudtrail" {
  count = local.enabled ? 1 : 0

  name   = "${local.name}-database-creator-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.cloudtrail.json
}

resource "aws_iam_role_policy_attachment" "cloudtrail" {
  count = local.enabled ? 1 : 0

  role       = one(aws_iam_role.cloudtrail[*].name)
  policy_arn = one(aws_iam_policy.cloudtrail[*].arn)
}

module "cloudtrail_s3_bucket" {
  count = local.enabled ? 1 : 0

  source  = "cloudposse/cloudtrail-s3-bucket/aws"
  version = "0.26.2"

  stage         = var.environment
  name          = local.name
  force_destroy = var.bucket_force_destroy
}

module "log_metric_filter" {
  count = var.sns_alarm_topic_arn != "" ? length(local.alarms) : 0

  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-metric-filter"
  version = "~> 4.2.0"

  log_group_name = one(aws_cloudwatch_log_group.cloudtrail[*].name)

  name    = "Cloudtrail - ${local.alarms[count.index].name}"
  pattern = local.alarms[count.index].pattern

  metric_transformation_namespace = "CloudTrail"
  metric_transformation_name      = local.alarms[count.index].name
  metric_transformation_value     = "1"

  depends_on = [aws_cloudwatch_log_group.cloudtrail]
}

module "metric_alarm" {
  count = var.sns_alarm_topic_arn != "" ? length(local.alarms) : 0

  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 4.2.0"

  alarm_name          = "Cloudtrail - ${local.alarms[count.index].name}"
  alarm_description   = local.alarms[count.index].description
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 1
  period              = 60

  namespace   = "CloudTrail"
  metric_name = local.alarms[count.index].name
  statistic   = "Sum"

  alarm_actions = [var.sns_alarm_topic_arn]
}

