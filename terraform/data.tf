data "aws_iam_policy_document" "ecs_trust" {
    statement {
      sid = "ECSTrustPolicy"
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["ecs-tasks.amazonaws.com"]
      }
    }
}

data "aws_iam_policy_document" "rds_secret" {
    statement {
      sid = "AllowECSToAccessRDSSecret"
      actions = [
        "secretsmanager:GetSecretValue"
      ]
      resources = ["${local.rds_secret_arn}"]
    }
}

data "aws_ssm_parameter" "rds_secret_arn" {
  name = "/timing/rds/rds_secret_arn"
}

data "aws_ssm_parameter" "vpc_id" {
  name = "/timing/vpc/vpc_id"
}


data "aws_ssm_parameter" "alb_security_group" {
  name = "/timing/vpc/alb_security_group"
}

data "aws_ssm_parameter" "rds_endpoint" {
  name = "/timing/rds/rds_endpoint"
}


data "aws_ssm_parameter" "rds_security_group" {
  name = "/timing/vpc/rds_security_group"
}




data "aws_ssm_parameter" "aws_ecs_cluster_id" {
  name = "/timing/ecs/aws_ecs_cluster_id"
}

data "aws_ssm_parameter" "private_subent" {
  name = "/timing/vpc/private_subnet_ids"
}

data "aws_ssm_parameter" "target_group_arn" {
  name = "/timing/ec2/target_group_arns"
}