locals {
  tags = {
    Name = "timing-api-backend"
    Environment = "DEV"
    Terraform = "true"
  }

 rds_secret_arn          = data.aws_ssm_parameter.rds_secret_arn.value
 vpc_id                  = data.aws_ssm_parameter.vpc_id.value
 alb_security_group_id   = data.aws_ssm_parameter.alb_security_group.value
 rds_security_group_id   = data.aws_ssm_parameter.rds_security_group.value
 aws_ecs_cluster_id      = data.aws_ssm_parameter.aws_ecs_cluster_id.value
 rds_endpoint            = split(":", data.aws_ssm_parameter.rds_endpoint.value)[0]
 private_subent          = split(",",data.aws_ssm_parameter.private_subent.value)
 target_group_arn       = data.aws_ssm_parameter.target_group_arn.value



 container_name          = "api-ecs"




 env_vars = [
    {
        "name" : "PORT"
        "value" : "3000"
    },
    {
        "name": "DB",
        "value" : "timing"
    },
    {
        "name": "DBUSER",
        "value" : "timingadmin"
    },

    {
        "name" : "DBPORT",
        "value" : "5432"
    },

    {

      "name" : "DBHOST",
      "value" : "${local.rds_endpoint}"
    }
]


 application_secrets = [
    {
        "name" : "DBPASS",
        "valueFrom" : "${local.rds_secret_arn}"
    }
  ]















}
