resource "aws_security_group" "allow_api_ecs" {
  name        = "allow_ecs"
  description = "This will only allow traffic from API ALB"
  vpc_id      = local.vpc_id


     egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

  tags = local.tags
}


resource "aws_security_group_rule" "allow_api_ecs" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.allow_api_ecs.id
  source_security_group_id = local.alb_security_group_id
}


#allowing traffic from API ECS on 5432
resource "aws_security_group_rule" "rds_rule" {
  type                     = "ingress"
  from_port                = 5432
  description              = "allowing traffic from API ECS on 5432"
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = local.rds_security_group_id
  source_security_group_id = aws_security_group.allow_api_ecs.id
}
